#include "../script_component.hpp"
params [["_unit", objNull, [objNull]], ["_player", objNull, [objNull]],["_forCompass", false]];
if (isNull _unit) exitWith {_rifleman};

if (!_forCompass && {diwako_dui_showRank}) exitWith {
    diwako_dui_icon_style getVariable [rank _unit, DUI_RANK_PRIVATE];
};

if !(isNull objectParent _unit || {_forCompass}) exitWith {
    private _crewInfo = ((fullCrew (vehicle _unit)) select {_x select 0 isEqualTo _unit}) select 0;
    _crewInfo params ["", "_role", "_index", "_turretPath", "_isTurret"];

    // Cargo
    if (_role == "cargo") exitWith {
        diwako_dui_icon_style getVariable ["vehicle_cargo", DUI_VEHICLE_CARGO];
    };

    // Drivers
    if (_role == "driver") exitWith {
        diwako_dui_icon_style getVariable ["vehicle_driver", DUI_VEHICLE_DRIVER];
    };

    // FFV
    if (_role == "turret" && _isTurret) exitWith {
        diwako_dui_icon_style getVariable ["fire_from_vehicle", DUI_FIRE_FROM_VEHICLE];
    };

    // Gunners or Copilots
    if (_role == "gunner" || (_role == "turret" && !_isTurret)) exitWith {
        diwako_dui_icon_style getVariable ["vehicle_gunner", DUI_VEHICLE_GUNNER];
    };

    // Commander
    if (_role == "commander") exitWith {
        diwako_dui_icon_style getVariable ["vehicle_commander", DUI_VEHICLE_COMMANDER];
    };
};

// Buddy
if (_player == (_unit getVariable ["diwako_dui_buddy", objNull])) exitWith {
    diwako_dui_icon_style getVariable ["buddy_compass", DUI_BUDDY_COMPASS];
};

// Leader
if (leader(_unit) == _unit) exitWith {
    diwako_dui_icon_style getVariable ["sql", DUI_SQL];
};

// AR
if (getText(configFile >> "CfgWeapons" >> (primaryWeapon (_unit)) >> "UIPicture") == "\a3\weapons_f\data\ui\icon_mg_ca.paa") exitWith {
    diwako_dui_icon_style getVariable ["auto_rifleman", DUI_AUTO_RIFLEMAN];
};

// AT
if (getText(configFile >> "CfgWeapons" >> (secondaryWeapon (_unit)) >> "UIPicture") == "\a3\weapons_f\data\ui\icon_at_ca.paa") exitWith {
    diwako_dui_icon_style getVariable ["at_gunner", DUI_AT_GUNNER];
};

// Medic
if (_unit getVariable ["ace_medical_medicClass", getNumber (configFile >> "CfgVehicles" >> typeOf _unit >> "attendant")] > 0) exitWith {
    diwako_dui_icon_style getVariable ["medic", DUI_MEDIC];
};

// Engineer
private _isEngineer = _unit getVariable ["ACE_isEngineer", _unit getUnitTrait "engineer"];
if (_isEngineer isEqualType 0) then {_isEngineer = _isEngineer > 0};

if (_isEngineer) exitWith {
    diwako_dui_icon_style getVariable ["engineer", DUI_ENGINEER];
};

// Explosive Specialist
if (_unit getVariable ["ACE_isEOD", _unit getUnitTrait "explosiveSpecialist"]) exitWith {
    diwako_dui_icon_style getVariable ["explosive_specialist", DUI_EXPLOSIVE_SPECIALIST];
}; 

diwako_dui_icon_style getVariable ["rifleman", DUI_RIFLEMAN];
