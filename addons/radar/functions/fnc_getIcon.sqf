#include "script_component.hpp"
params [["_unit", objNull, [objNull]], "_namespace", ["_player", objNull, [objNull]], ["_forCompass", false]];

if (isNull _unit) exitWith {_namespace getVariable ["rifleman", DUI_RIFLEMAN];};

if (!_forCompass && {GVAR(showRank)}) exitWith {
    _namespace getVariable [rank _unit, DUI_RANK_PRIVATE];
};

if !(isNull objectParent _unit || {_forCompass}) exitWith {
    private _crewInfo = ((fullCrew (vehicle _unit)) select {_x select 0 isEqualTo _unit}) select 0;
    _crewInfo params ["", "_role", "", "", "_isTurret"];

    // Cargo
    if (_role == "cargo") exitWith {
        _namespace getVariable ["vehicle_cargo", DUI_VEHICLE_CARGO];
    };

    // Drivers
    if (_role == "driver") exitWith {
        _namespace getVariable ["vehicle_driver", DUI_VEHICLE_DRIVER];
    };

    // FFV
    if (_role == "turret" && _isTurret) exitWith {
        _namespace getVariable ["fire_from_vehicle", DUI_FIRE_FROM_VEHICLE];
    };

    // Gunners or Copilots
    if (_role == "gunner" || (_role == "turret" && !_isTurret)) exitWith {
        _namespace getVariable ["vehicle_gunner", DUI_VEHICLE_GUNNER];
    };

    // Commander
    if (_role == "commander") exitWith {
        _namespace getVariable ["vehicle_commander", DUI_VEHICLE_COMMANDER];
    };
};

// Custom icon
if (_unit getVariable [QGVAR(customIcon), ""] isNotEqualTo "") exitWith {
    _unit getVariable QGVAR(customIcon);
};

// Buddy
if (_player == (_unit getVariable [QEGVAR(buddy,buddy), objNull])) exitWith {
    _namespace getVariable ["buddy_compass", DUI_BUDDY_COMPASS];
};

// Leader
if ((leader _unit) isEqualTo _unit) exitWith {
    _namespace getVariable ["sql", DUI_SQL];
};

// AR
if (getText(configFile >> "CfgWeapons" >> (primaryWeapon (_unit)) >> "UIPicture") == "\a3\weapons_f\data\ui\icon_mg_ca.paa") exitWith {
    _namespace getVariable ["auto_rifleman", DUI_AUTO_RIFLEMAN];
};

// AT
if (getText(configFile >> "CfgWeapons" >> (secondaryWeapon (_unit)) >> "UIPicture") == "\a3\weapons_f\data\ui\icon_at_ca.paa") exitWith {
    _namespace getVariable ["at_gunner", DUI_AT_GUNNER];
};

// Medic
if (GVAR(ace_medic) && {_unit getVariable ["ace_medical_medicClass", [0, 1] select (_unit getUnitTrait "medic")] > 0}) exitWith {
    _namespace getVariable ["medic", DUI_MEDIC];
};
if (!GVAR(ace_medic) && {_unit getUnitTrait "medic"}) exitWith {
    _namespace getVariable ["medic", DUI_MEDIC];
};

// Engineer
private _isEngineer = _unit getVariable ["ACE_isEngineer", _unit getUnitTrait "engineer"];
if (_isEngineer isEqualType 0) then {_isEngineer = _isEngineer > 0};

if (_isEngineer) exitWith {
    _namespace getVariable ["engineer", DUI_ENGINEER];
};

// Explosive Specialist
if (_unit getVariable ["ACE_isEOD", false] || {_unit getUnitTrait "explosiveSpecialist"}) exitWith {
    _namespace getVariable ["explosive_specialist", DUI_EXPLOSIVE_SPECIALIST];
};

_namespace getVariable ["rifleman", DUI_RIFLEMAN];
