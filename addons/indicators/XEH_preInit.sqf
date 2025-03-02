#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"

GVAR(drawEh) = -1;

#define CBA_SETTINGS_CAT (format ["%1 - %2", localize "STR_dui_mod", localize "STR_dui_addon_indicators"])

[
    QGVAR(show)
    ,"CHECKBOX"
    ,[localize "STR_dui_indicators_show", localize "STR_dui_indicators_show_desc"]
    ,CBA_SETTINGS_CAT
    ,true
] call CBA_fnc_addSetting;

#define DUI_INDICATORS_MIN_RANGE 15
#define DUI_INDICATORS_MAX_RANGE 500
#define DUI_INDICATORS_DEFAULT_MAX_RANGE 100
#define DUI_INDICATORS_MIN_RANGE_CREW 15
#define DUI_INDICATORS_MAX_RANGE_CREW 1000
[
    QGVAR(range)
    ,"SLIDER"
    ,[localize "STR_dui_indicators_range", localize "STR_dui_indicators_range_desc"]
    ,CBA_SETTINGS_CAT
    ,[DUI_INDICATORS_MIN_RANGE, DUI_INDICATORS_MAX_RANGE, 20, 0]
    ,false
] call CBA_fnc_addSetting;

[
    QGVAR(rangeLimit)
    ,"SLIDER"
    ,[localize "STR_dui_indicators_range_limit", localize "STR_dui_indicators_range_limit_desc"]
    ,CBA_SETTINGS_CAT
    ,[DUI_INDICATORS_MIN_RANGE, DUI_INDICATORS_MAX_RANGE, DUI_INDICATORS_DEFAULT_MAX_RANGE, 0]
    ,true
] call CBA_fnc_addSetting;

[
    QGVAR(crew_range_enabled)
    ,"CHECKBOX"
    ,[localize "STR_dui_indicators_crew_enabled", localize "STR_dui_indicators_crew_enabled_desc"]
    ,CBA_SETTINGS_CAT
    ,false
    ,true
] call CBA_fnc_addSetting;

[
    QGVAR(range_crew)
    ,"SLIDER"
    ,[localize "STR_dui_indicators_crew_range", localize "STR_dui_indicators_crew_range_desc"]
    ,CBA_SETTINGS_CAT
    ,[DUI_INDICATORS_MIN_RANGE_CREW, DUI_INDICATORS_MAX_RANGE_CREW, 300, 0]
    ,false
] call CBA_fnc_addSetting;

[
    QGVAR(size)
    ,"SLIDER"
    ,[localize "STR_dui_indicators_size", localize "STR_dui_indicators_size_desc"]
    ,CBA_SETTINGS_CAT
    ,[0.1, 4, 1, 2]
    ,false
] call CBA_fnc_addSetting;

#include "include\getIndicatorStyles.sqf"
[
    QGVAR(style)
    ,"LIST"
    ,[localize "STR_dui_indicators_style", localize "STR_dui_indicators_style_desc"]
    ,CBA_SETTINGS_CAT
    ,[
        _indicatorNames,
        _indicatorPaths,
        0
    ]
    ,false
] call CBA_fnc_addSetting;

[
    QGVAR(range_scale)
    ,"CHECKBOX"
    ,[localize "STR_dui_indicators_range_scale", localize "STR_dui_indicators_range_scale_desc"]
    ,CBA_SETTINGS_CAT
    ,false
] call CBA_fnc_addSetting;

[
    QGVAR(fov_scale)
    ,"CHECKBOX"
    ,[localize "STR_dui_indicators_fov_scale", localize "STR_dui_indicators_fov_scale_desc"]
    ,CBA_SETTINGS_CAT
    ,false
] call CBA_fnc_addSetting;

if (isClass (configFile >> "CfgPatches" >> "ace_nametags")) then {
    [
        QGVAR(useACENametagsRange)
        ,"CHECKBOX"
        ,[localize "STR_dui_indicators_useACENametagsRange", localize "STR_dui_indicators_useACENametagsRange_desc"]
        ,CBA_SETTINGS_CAT
        ,true
    ] call CBA_fnc_addSetting;
} else {
    GVAR(useACENametagsRange) = false;
};

private _curCat = localize "STR_dui_cat_icons";

[
    QGVAR(icon_leader)
    ,"CHECKBOX"
    ,localize "STR_dui_indicators_icon_leader"
    ,[CBA_SETTINGS_CAT, _curCat]
    ,true
] call CBA_fnc_addSetting;

if (isClass(configFile >> "CfgPatches" >> "diwako_dui_buddy")) then {
    [
        QGVAR(icon_buddy)
        ,"CHECKBOX"
        ,localize "STR_dui_indicators_icon_buddy"
        ,[CBA_SETTINGS_CAT, _curCat]
        ,true
    ] call CBA_fnc_addSetting;
} else {
    GVAR(icon_buddy) = false;
};

[
    QGVAR(icon_medic)
    ,"CHECKBOX"
    ,localize "STR_dui_indicators_icon_medic"
    ,[CBA_SETTINGS_CAT, _curCat]
    ,true
] call CBA_fnc_addSetting;

ADDON = true;
