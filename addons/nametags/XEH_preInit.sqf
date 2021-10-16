#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"

GVAR(RankNames) = createHashMap;

{
    private _config = _x;
    private _configName = configName _x ;
    private _rankHashMap = createHashMap;
    {
        private _text = getText (_config >> toLower _x);
        _rankHashMap set [_x, _text];
    } forEach ["PRIVATE","CORPORAL","SERGEANT","LIEUTENANT","CAPTAIN","MAJOR","COLONEL","displayName"];
    if (_configName isEqualTo "default") then {
        {
            if ("displayName" isNotEqualTo _x) then {
                _rankHashMap set [_x, _y + "."];
            };
        } forEach _rankHashMap;
    };
    GVAR(RankNames) set [_configName, _rankHashMap];
} forEach ("isClass _x" configClasses (configFile >> "diwako_dui_rankNameStyles"));

#include "settings.sqf"
ADDON = true;
