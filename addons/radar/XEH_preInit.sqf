#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"

#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#define CBA_SETTINGS_CAT (format ["%1 - %2",localize "STR_dui_mod", localize "STR_dui_addon_radar"])

// Scale by the height of the monitor as that's a better indicator of DPI than width.
// We use 1080p as our reference as that's what diwako calibrated everything on.
private _saneScale = (getResolution select 1) / 1080; 

GVAR(group) = [];
GVAR(compass_pfHandle) = -1;
GVAR(namebox_lists) = [];
GVAR(showRank) = false;
GVAR(setCompass) = true;
GVAR(setNamelist) = true;

private _curCat = localize "STR_dui_cat_general";

[
    "diwako_dui_show_squadbar"
    ,"CHECKBOX"
    ,[localize "STR_dui_show_squadbar", localize "STR_dui_show_squadbar_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,true
    ,false
    ,{
        params ["_value"];
        // disable/enable vanilla squadbar
        private _showHud = shownHUD;
        _showHud set [6, _value];
        showHud (_showHud select [0, 8]);
    }
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
        [QGVAR(refreshUI),[]] call CBA_fnc_localEvent;
    }
] call CBA_Settings_fnc_init;

#include "include\getCompassStyles.sqf"
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
        [QGVAR(refreshUI),[]] call CBA_fnc_localEvent;
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
        if (GVAR(compass_pfHandle) > -1) then {
            private _index = CBA_common_PFHhandles param [GVAR(compass_pfHandle)];
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
    "diwako_dui_enable_occlusion_cone"
    ,"SLIDER"
    ,[localize "STR_dui_occlusion_cone", localize "STR_dui_occlusion_cone_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,[0, 360, 360, 1]
    ,false
    ,{
        params ["_value"];
        GVAR(enable_occlusion_actual_cone) = _value / 2;
    }
] call CBA_Settings_fnc_init;

[
    QGVAR(occlusion_fade_time)
    ,"SLIDER"
    ,[localize "STR_dui_occlusion_fade_time", localize "STR_dui_occlusion_fade_time_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,[2, 60, 10, 1]
    ,false
] call CBA_Settings_fnc_init;

[
    "diwako_dui_compass_icon_scale"
    ,"SLIDER"
    ,[localize "STR_dui_compass_icon_scale", localize "STR_dui_compass_icon_scale_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,[0.01, 6, 1, 2]
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
        [QGVAR(refreshUI),[]] call CBA_fnc_localEvent;
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

[
    QGVAR(trackingColor)
    ,"COLOR"
    ,[localize "STR_dui_trackingColor_time", localize "STR_dui_trackingColor_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,[0.93, 0.26, 0.93, 1]
    ,false
] call CBA_settings_fnc_init;

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
        [QGVAR(refreshUI),[]] call CBA_fnc_localEvent;
    }
] call CBA_Settings_fnc_init;

[
    "diwako_dui_namelist_size"
    ,"SLIDER"
    ,[localize "STR_dui_namelist_size", localize "STR_dui_namelist_size_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,[0.5, 3, (_saneScale^1.5), 8]
    ,false
    ,{
        [QGVAR(refreshUI),[]] call CBA_fnc_localEvent;
    }
] call CBA_Settings_fnc_init;

[
    "diwako_dui_namelist_bg"
    ,"SLIDER"
    ,[localize "STR_dui_namelist_bg", localize "STR_dui_namelist_bg_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,[0, 1, 0, 2]
    ,false
    ,{
        [QGVAR(refreshUI),[]] call CBA_fnc_localEvent;
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
        [QGVAR(refreshUI),[]] call CBA_fnc_localEvent;
    }
] call CBA_Settings_fnc_init;

[
    QGVAR(namelist_vertical_spacing)
    ,"SLIDER"
    ,[localize "STR_dui_namelist_vertical_spacing", localize "STR_dui_namelist_vertical_spacing_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,[0, 5, 1/_saneScale, 3]
    ,false
    ,{
        [QGVAR(refreshUI),[]] call CBA_fnc_localEvent;
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
        [QGVAR(refreshUI),[]] call CBA_fnc_localEvent;
    }
] call CBA_Settings_fnc_init;

[
    QGVAR(namelist_hideWhenLeader)
    ,"CHECKBOX"
    ,[localize "STR_dui_namelist_hideWhenLeader", localize "STR_dui_namelist_hideWhenLeader_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,false
    ,false
] call CBA_Settings_fnc_init;

[
    "diwako_dui_hudScaling"
    ,"SLIDER"
    ,[localize "STR_dui_ui_scale", ""]
    ,[CBA_SETTINGS_CAT, localize "STR_dui_cat_general"]
    ,[0.5, 3, _saneScale, 2]
    ,false
    ,{
        params ["_value"];
        GVAR(uiPixels) = 128 * _value;

        [QGVAR(refreshUI),[]] call CBA_fnc_localEvent;
    }
] call CBA_Settings_fnc_init;

private _curCat = localize "STR_dui_cat_layout";

[
    "diwako_dui_use_layout_editor"
    ,"CHECKBOX"
    ,[localize "STR_dui_layout", localize "STR_dui_layout_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,false
    ,false
    ,{
        [QGVAR(refreshUI),[]] call CBA_fnc_localEvent;
    }
] call CBA_Settings_fnc_init;

[
    "diwako_dui_reset_ui_pos"
    ,"CHECKBOX"
    ,[localize "STR_dui_reset_ui_pos", localize "STR_dui_reset_ui_pos_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,false
    ,false
    ,{
        params ["_value"];
        if (_value) then {
            ["diwako_dui_reset_ui_pos", false, 0, "server", true] call CBA_settings_fnc_set;
            ["diwako_dui_reset_ui_pos", false, 0, "mission", true] call CBA_settings_fnc_set;
            ["diwako_dui_reset_ui_pos", false, 0, "client", true] call CBA_settings_fnc_set;
            profileNamespace setVariable ["igui_diwako_dui_compass_w", nil];
            profileNamespace setVariable ["igui_diwako_dui_compass_x", 0.5 - (pixelW * (GVAR(uiPixels) / 2))];
            profileNamespace setVariable ["igui_diwako_dui_compass_y", safeZoneY + safeZoneH - (pixelH * (GVAR(uiPixels) + 10))];
            profileNamespace setVariable ["igui_diwako_dui_compass_h", nil];
            profileNamespace setVariable ["igui_diwako_dui_namelist_w", nil];
            profileNamespace setVariable ["igui_diwako_dui_namelist_x", 0.5 + (pixelW * (GVAR(uiPixels) / 2 + 10))];
            profileNamespace setVariable ["igui_diwako_dui_namelist_y", safeZoneY + safeZoneH - (pixelH * (GVAR(uiPixels) + 10))];
            profileNamespace setVariable ["igui_diwako_dui_namelist_h", nil];
            saveProfileNamespace;

            [QGVAR(refreshUI),[]] call CBA_fnc_localEvent;
        };
    }
] call CBA_Settings_fnc_init;

if !(hasInterface) exitWith {};

// Reposition the actual ui elements when layout editor save button was pressed (CBA 3.10)
["CBA_layoutEditorSaved", {
    [QGVAR(refreshUI),[]] call CBA_fnc_localEvent;
}, true] call CBA_fnc_addEventHandler;

// keybinds for zooming
[CBA_SETTINGS_CAT, "diwako_dui_button_increase_range", localize "STR_dui_key_increase_range", {
    [true] call FUNC(rangeButton);
    true
},
{false},
[DIK_NUMPADPLUS, [false, true, false]], false] call CBA_fnc_addKeybind;

[CBA_SETTINGS_CAT, "diwako_dui_button_decrease_range", localize "STR_dui_key_decrease_range", {
    [false] call FUNC(rangeButton);
    true
},
{false},
[DIK_NUMPADMINUS, [false, true, false]], false] call CBA_fnc_addKeybind;

[CBA_SETTINGS_CAT, "diwako_dui_button_showRank", localize "STR_dui_key_rank", {
    GVAR(showRank) = true;
    true
},
{
    GVAR(showRank) = false;
    true
}] call CBA_fnc_addKeybind;


ADDON = true;
