#include "../script_component.hpp"
params [["_unit", objNull, [objNull]], ["_player", objNull, [objNull]],["_forCompass", false]];
if (isNull _unit) exitWith {_rifleman};

diwako_dui_icon_style params ["_sql", "_medic", "_auto_rifleman", "_at_gunner", "_engineer", "_explosive_specialist", "_rifleman", "_vehicle_cargo", "_vehicle_driver", "_fire_from_vehicle", "_vehicle_gunner", "_vehicle_commander", "_rank_private", "_rank_corporal", "_rank_sergeant", "_rank_lieutenant", "_rank_captain", "_rank_major", "_rank_colonel", "_buddy"];

if (!_forCompass && {diwako_dui_showRank}) exitWith {
        private _rank = rank _unit;
    if (_rank =="PRIVATE") exitWith {_rank_private};
    if (_rank =="CORPORAL") exitWith {_rank_corporal};
    if (_rank =="SERGEANT") exitWith {_rank_sergeant};
    if (_rank =="LIEUTENANT") exitWith {_rank_lieutenant};
    if (_rank =="CAPTAIN") exitWith {_rank_captain};
    if (_rank =="MAJOR") exitWith {_rank_major};
    if (_rank =="COLONEL") exitWith {_rank_colonel};
};

if !(isNull objectParent _unit || {_forCompass}) exitWith {
    private _crewInfo = ((fullCrew (vehicle _unit)) select {_x select 0 isEqualTo _unit}) select 0;
    _crewInfo params ["", "_role", "_index", "_turretPath", "_isTurret"];

    if (_role == "cargo") exitWith {
        _vehicle_cargo
    };

    if (_role == "driver") exitWith {
        // if (vehicle _unit isKindOf "Air") then
        // {
        // //no suitable icons for this so we are using a resized one
        // "@stui\addons\grouphud\imagepilot_ca.paa"
        // } else
        // {
            _vehicle_driver
        // };
    };

    //FFV
    if (_role == "turret" && _isTurret) exitWith {
        _fire_from_vehicle
    };

    //gunners and sometimes copilots
    if (_role == "gunner" || (_role == "turret" && !_isTurret)) exitWith {
        _vehicle_gunner
    };
    if (_role == "commander") exitWith {
        _vehicle_commander
    };
};

// Buddy
if (_player == (_unit getVariable ["diwako_dui_buddy", objNull])) exitWith {
    _buddy
};

// Leader
if (leader(_unit) == _unit) exitWith {
    _sql
};

// AR
if (getText(configFile >> "CfgWeapons" >> (primaryWeapon (_unit)) >> "UIPicture") == "\a3\weapons_f\data\ui\icon_mg_ca.paa") exitWith {
    _auto_rifleman
};

// AT
if (getText(configFile >> "CfgWeapons" >> (secondaryWeapon (_unit)) >> "UIPicture") == "\a3\weapons_f\data\ui\icon_at_ca.paa") exitWith {
    _at_gunner
};

// Medic
if (_unit getVariable ["ace_medical_medicClass", getNumber (configFile >> "CfgVehicles" >> typeOf _unit >> "attendant")] > 0) exitWith {
    _medic
};

// Engineer
private _isEngineer = _unit getVariable ["ACE_isEngineer", _unit getUnitTrait "engineer"];
if (_isEngineer isEqualType 0) then {_isEngineer = _isEngineer > 0};

if (_isEngineer) exitWith {
    _engineer
};

// Explosive Specialist
if (_unit getVariable ["ACE_isEOD", _unit getUnitTrait "explosiveSpecialist"]) exitWith {
    _explosive_specialist
}; 

_rifleman