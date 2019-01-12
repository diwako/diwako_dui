#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "../script_component.hpp"
#define CBA_SETTINGS_CAT localize "STR_dui_mod"

diwako_dui_group = [];
diwako_dui_compass_pfHandle = -1;
diwako_dui_namebox_lists = [];
diwako_dui_toggled_off = false;
diwako_dui_showRank = false;

private _curCat = localize "STR_dui_cat_general";

private _availableFonts = [
    "PuristaBold",
    "PuristaLight",
    "PuristaMedium",
    "PuristaSemibold",
    "RobotoCondensed",
    "RobotoCondensedBold",
    "RobotoCondensedLight",
    "EtelkaMonospacePro",
    // "EtelkaMonospaceProBold",
    // "EtelkaNarrowMediumPro",
    "LCD14"
    // "TahomaB"
];

[
    "diwako_dui_font"
    ,"LIST"
    ,[localize "STR_dui_font", localize "STR_dui_font_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,[
        _availableFonts,
        _availableFonts,
        4
    ]
    ,false
] call CBA_Settings_fnc_init;

private _iconStyles = [] call diwako_dui_fnc_getIconStyles;
[
    "diwako_dui_icon_style"
    ,"LIST"
    ,[localize "STR_dui_icon", localize "STR_dui_icon_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,[
        _iconStyles select 1,
        _iconStyles select 0,
        0
    ]
    ,false
] call CBA_Settings_fnc_init;

private _colorStyles = [] call diwako_dui_fnc_getColorStyles;
[
    "diwako_dui_colors"
    ,"LIST"
    ,[localize "STR_dui_color", localize "STR_dui_color_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,[
        _colorStyles select 1,
        _colorStyles select 0,
        0
    ]
    ,false
] call CBA_Settings_fnc_init;


private _curCat = localize "STR_dui_cat_compass";

[
    "diwako_dui_enable_compass"
    ,"CHECKBOX"
    ,[localize "STR_dui_show_compass", localize "STR_dui_show_compass_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,true
    ,false
] call CBA_Settings_fnc_init;

[
    "diwako_dui_enable_compass_dir"
    ,"CHECKBOX"
    ,[localize "STR_dui_show_dir", localize "STR_dui_show_dir_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,true
    ,false
] call CBA_Settings_fnc_init;

[
    "diwako_dui_dir_showMildot"
    ,"CHECKBOX"
    ,[localize "STR_dui_show_milrad", localize "STR_dui_show_milrad_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,false
    ,false
] call CBA_Settings_fnc_init;

private _compassStyles = [] call diwako_dui_fnc_getCompassStyles;
[
    "diwako_dui_compass_style"
    ,"LIST"
    ,[localize "STR_dui_compass_style", localize "STR_dui_compass_style_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,[
        _compassStyles select 1,
        _compassStyles select 0,
        0
    ]
    ,false
] call CBA_Settings_fnc_init;

[
    "diwako_dui_compassRange"
    ,"SLIDER"
    ,[localize "STR_dui_compass_range", localize "STR_dui_compass_range_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,[DUI_MIN_RANGE, DUI_MAX_RANGE, 35, 0]
    ,false
] call CBA_Settings_fnc_init;

[
    "diwako_dui_compassRefreshrate"
    ,"SLIDER"
    ,[localize "STR_dui_compass_refresh", localize "STR_dui_compass_refresh_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,[0, 10, 0, 2]
    ,false
    ,{
        params ["_value"];
        if (diwako_dui_compass_pfHandle > -1) then {
            private _index = CBA_common_PFHhandles param [diwako_dui_compass_pfHandle];
            (CBA_common_perFrameHandlerArray select _index) set [1, _value];
        };
    }
] call CBA_Settings_fnc_init;

[
    "diwako_dui_enable_occlusion"
    ,"CHECKBOX"
    ,[localize "STR_dui_occlusion", localize "STR_dui_occlusion_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,false
    ,false
] call CBA_Settings_fnc_init;

// todo display to change the position in-game (should reset to center of screen)(0.5,0.5)
// todo keydown or option for ^ (or addAction(resets after use))
// save it in profileNamespace
// + scaling
// + reset per axis

private _curCat = localize "STR_dui_cat_namelist";

[
    "diwako_dui_namelist"
    ,"CHECKBOX"
    ,[localize "STR_dui_namelist", localize "STR_dui_namelist_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,true
    ,false
] call CBA_Settings_fnc_init;

[
    "diwako_dui_namelist_size"
    ,"SLIDER"
    ,[localize "STR_dui_namelist_size", localize "STR_dui_namelist_size_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,[0.5, 1.75, 1, 2]
    ,false
] call CBA_Settings_fnc_init;

[
    "diwako_dui_namelist_only_buddy_icon"
    ,"CHECKBOX"
    ,[localize "STR_dui_namelist_buddy", localize "STR_dui_namelist_buddy_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,false
    ,false
] call CBA_Settings_fnc_init;


// keybind to toggle whole UI
[CBA_SETTINGS_CAT, "diwako_dui_button_toggle_ui", localize "STR_dui_key_toggle", {
    diwako_dui_toggled_off = !diwako_dui_toggled_off;
    true
},
{false},
[DIK_MULTIPLY, [false, true, false]], false] call CBA_fnc_addKeybind;

// keybinds for zooming
[CBA_SETTINGS_CAT, "diwako_dui_button_increase_range", localize "STR_dui_key_increase_range", {
    [true] call diwako_dui_fnc_rangeButton;
    true
},
{false},
[DIK_NUMPADPLUS, [false, true, false]], false] call CBA_fnc_addKeybind;

[CBA_SETTINGS_CAT, "diwako_dui_button_decrease_range", localize "STR_dui_key_decrease_range", {
    [false] call diwako_dui_fnc_rangeButton;
    true
},
{false},
[DIK_NUMPADMINUS, [false, true, false]], false] call CBA_fnc_addKeybind;

[CBA_SETTINGS_CAT, "diwako_dui_button_showRank", localize "STR_dui_key_rank", {
    diwako_dui_showRank = true;
    true
},
{
    diwako_dui_showRank = false;
    true
}] call CBA_fnc_addKeybind;
