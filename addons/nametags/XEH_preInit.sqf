#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"

GVAR(RankNames) = createHashMap;

{
    private _config = _x;
    private _rankHashMap = createHashMap;
    {
        private _text = getText (_config >> _x);
        _rankHashMap set [_x, _text];
    } forEach ["PRIVATE","CORPORAL","SERGEANT","LIEUTENANT","CAPTAIN","MAJOR","COLONEL"];
    GVAR(RankNames) set [configName _x, _rankHashMap];
} forEach "isClass _x" configClasses (configFile >> "CfgRankNameStyles");

#include "settings.sqf"
ADDON = true;
