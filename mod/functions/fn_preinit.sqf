#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "../script_component.hpp"
#define CBA_SETTINGS_CAT localize "STR_dui_mod"

diwako_dui_group = [];
diwako_dui_compass_pfHandle = -1;
diwako_dui_namebox_lists = [];
diwako_dui_toggled_off = false;
diwako_dui_showRank = false;
diwako_dui_inFeatureCamera = false;
diwako_dui_setCompass = true;
diwako_dui_setNamelist = true;

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
    "LCD14",
    "Bombardier"
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
    ,{
        diwako_dui_setCompass = true;
        for "_i" from 0 to (count diwako_dui_namebox_lists) do {
            ctrlDelete ctrlParentControlsGroup (diwako_dui_namebox_lists deleteAt 0);
        };
    }
] call CBA_Settings_fnc_init;

// include the sqf file as the compiled cfgfunction is not available during some preinit events
#include "fn_getIconStyles.sqf"
[
    "diwako_dui_icon_style"
    ,"LIST"
    ,[localize "STR_dui_icon", localize "STR_dui_icon_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,[
        _iconIdent,
        _iconNames,
        0
    ]
    ,false
] call CBA_Settings_fnc_init;

#include "fn_getColorStyles.sqf"
[
    "diwako_dui_colors"
    ,"LIST"
    ,[localize "STR_dui_color", localize "STR_dui_color_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,[
        _colorIdent,
        _colorNames,
        0
    ]
    ,false
] call CBA_Settings_fnc_init;

if (isClass(configfile >> "CfgPatches" >> "ace_interact_menu")) then {
    [
        "diwako_dui_ace_hide_interaction"
        ,"CHECKBOX"
        ,[localize "STR_dui_ace_hide_interaction", localize "STR_dui_ace_hide_interaction_desc"]
        ,[CBA_SETTINGS_CAT, _curCat]
        ,true
        ,false
    ] call CBA_Settings_fnc_init;
} else {
    diwako_dui_ace_hide_interaction = false;
};


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
    ,"LIST"
    ,[localize "STR_dui_show_dir", localize "STR_dui_show_dir_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,[
        [0,1,2],
        [localize "STR_dui_show_dir_opt1",localize "STR_dui_show_dir_opt2",localize "STR_dui_show_dir_opt3"],
        1
    ]
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

[
    "diwako_dui_dir_size"
    ,"SLIDER"
    ,[localize "STR_dui_dir_size", localize "STR_dui_dir_size_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,[0, 3, 1.25, 2]
    ,false
    ,{
        diwako_dui_setCompass = true;
    }
] call CBA_Settings_fnc_init;

#include "fn_getCompassStyles.sqf"
[
    "diwako_dui_compass_style"
    ,"LIST"
    ,[localize "STR_dui_compass_style", localize "STR_dui_compass_style_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,[
        _compassPaths,
        _compassNames,
        0
    ]
    ,false
    ,{
        diwako_dui_setCompass = true;
    }
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

[
    "diwako_dui_compass_icon_scale"
    ,"SLIDER"
    ,[localize "STR_dui_compass_icon_scale", localize "STR_dui_compass_icon_scale_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,[0.01, 4, 1, 2]
    ,false
] call CBA_Settings_fnc_init;

[
    "diwako_dui_compass_opacity"
    ,"SLIDER"
    ,[localize "STR_dui_compass_opacity", localize "STR_dui_compass_opacity_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,[0, 1, 1, 2]
    ,false
    ,{
        diwako_dui_setCompass = true;
    }
] call CBA_Settings_fnc_init;

[
    "diwako_dui_distanceWarning"
    ,"SLIDER"
    ,[localize "STR_dui_compass_warning", localize "STR_dui_compass_warning_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,[0, 50, 3, 1]
    ,false
] call CBA_Settings_fnc_init;

[
    "diwako_dui_compass_hide_alone_group"
    ,"CHECKBOX"
    ,[localize "STR_dui_compass_hide_when_alone", localize "STR_dui_compass_hide_when_alone_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,false
    ,false
] call CBA_Settings_fnc_init;

[
    "diwako_dui_compass_hide_blip_alone_group"
    ,"CHECKBOX"
    ,[localize "STR_dui_compass_hide_blip_when_alone", localize "STR_dui_compass_hide_blip_when_alone_desc"]
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
    ,{
        diwako_dui_setNamelist = true;
    }
] call CBA_Settings_fnc_init;

[
    "diwako_dui_namelist_size"
    ,"SLIDER"
    ,[localize "STR_dui_namelist_size", localize "STR_dui_namelist_size_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,[0.5, 3, 1, 2]
    ,false
] call CBA_Settings_fnc_init;

[
    "diwako_dui_namelist_bg"
    ,"SLIDER"
    ,[localize "STR_dui_namelist_bg", localize "STR_dui_namelist_bg_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,[0, 1, 0, 2]
    ,false
    ,{
        for "_i" from 0 to (count diwako_dui_namebox_lists) do {
            ctrlDelete ctrlParentControlsGroup (diwako_dui_namebox_lists deleteAt 0);
        };
    }
] call CBA_Settings_fnc_init;

[
    "diwako_dui_namelist_only_buddy_icon"
    ,"CHECKBOX"
    ,[localize "STR_dui_namelist_buddy", localize "STR_dui_namelist_buddy_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,false
    ,false
] call CBA_Settings_fnc_init;


[
    "diwako_dui_namelist_width"
    ,"SLIDER"
    ,[localize "STR_dui_namelist_width", localize "STR_dui_namelist_width_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,[100, 500, 215, 0]
    ,false
    ,{
        params ["_value"];
        diwako_dui_setNamelist = true;

        for "_i" from 0 to (count diwako_dui_namebox_lists) do {
            ctrlDelete ctrlParentControlsGroup (diwako_dui_namebox_lists deleteAt 0);
        };
    }
] call CBA_Settings_fnc_init;

[
    "diwako_dui_namelist_text_shadow"
    ,"LIST"
    ,[localize "STR_dui_namelist_text_shadow", localize "STR_dui_namelist_text_shadow_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,[
        [0, 1, 2],
        [
            localize "STR_dui_namelist_text_shadow_0",
            localize "STR_dui_namelist_text_shadow_1",
            localize "STR_dui_namelist_text_shadow_2"
        ],
        2
    ]
    ,false
    ,{
        diwako_dui_setCompass = true;
    }
] call CBA_Settings_fnc_init;


[
    "diwako_dui_hudScaling"
    ,"SLIDER"
    ,[localize "STR_dui_ui_scale", ""]
    ,[CBA_SETTINGS_CAT, localize "STR_dui_cat_general"]
    ,[0.5, 3, 1, 2]
    ,false
    ,{
        params ["_value"];
        diwako_dui_setCompass = true;
        diwako_dui_setNamelist = true;
        diwako_dui_uiPixels = 128 * _value;

        for "_i" from 0 to (count diwako_dui_namebox_lists) do {
            ctrlDelete ctrlParentControlsGroup (diwako_dui_namebox_lists deleteAt 0);
        };
    }
] call CBA_Settings_fnc_init;


// keybind to toggle whole UI
[CBA_SETTINGS_CAT, "diwako_dui_button_toggle_ui", localize "STR_dui_key_toggle", {
    diwako_dui_toggled_off = !diwako_dui_toggled_off;

    if (diwako_dui_toggled_off) then {
        // set position and size for namelist and compassa gain
        diwako_dui_setCompass = true;
        diwako_dui_setNamelist = true;
        for "_i" from 0 to (count diwako_dui_namebox_lists) do {
            ctrlDelete ctrlParentControlsGroup (diwako_dui_namebox_lists deleteAt 0);
        };
    };
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
