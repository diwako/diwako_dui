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

// some compasses have less then 360 degrees
GVAR(oddDirectionCompasses) = [] call CBA_fnc_createNamespace;
GVAR(oddDirectionCompasses) setVariable ["gm_ge_army_conat2", 6400];
GVAR(oddDirectionCompasses) setVariable ["gm_gc_compass_f73", 6000];
GVAR(oddDirectionCompasses) setVariable ["lib_ger_itemcompass", 6400];
GVAR(maxDegrees) = 360;

private _tfar = isClass (configFile >> "CfgPatches" >> "task_force_radio");
private _acre = isClass (configFile >> "CfgPatches" >> "acre_main");
private _curCat = localize "STR_dui_cat_general";

if !(isClass(configFile >> "CfgPatches" >> "ace_ui")) then {
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
            private _showHUD = shownHUD;
            _showHUD set [6, _value];
            showHUD (_showHUD select [0, 8]);
        }
    ] call CBA_fnc_addSetting;
};

if (_acre || _tfar) then {
    [
        QGVAR(showSpeaking)
        ,"CHECKBOX"
        ,[localize "STR_dui_radar_show_speaking", localize "STR_dui_radar_show_speaking_desc"]
        ,[CBA_SETTINGS_CAT, _curCat]
        ,true
        ,false
    ] call CBA_fnc_addSetting;

    [
        QGVAR(showSpeaking_replaceIcon)
        ,"CHECKBOX"
        ,[localize "STR_dui_radar_show_speaking_replace_icon", localize "STR_dui_radar_show_speaking_replace_icon_desc"]
        ,[CBA_SETTINGS_CAT, _curCat]
        ,true
        ,false
    ] call CBA_fnc_addSetting;

    [
        QGVAR(showSpeaking_radioOnly)
        ,"CHECKBOX"
        ,[localize "STR_dui_radar_show_speaking_only_radio", localize "STR_dui_radar_show_speaking_only_radio_desc"]
        ,[CBA_SETTINGS_CAT, _curCat]
        ,false
        ,false
    ] call CBA_fnc_addSetting;
} else {
    GVAR(showSpeaking) = false;
    GVAR(showSpeaking_replaceIcon) = false;
};

if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then {
    [
        QGVAR(ace_medic)
        ,"CHECKBOX"
        ,[LSTRING(ace_medic), LSTRING(ace_medic_desc)]
        ,[CBA_SETTINGS_CAT, _curCat]
        ,true
        ,true
    ] call CBA_fnc_addSetting;

} else {
    GVAR(ace_medic) = false;
};

[
    QGVAR(icon_priority_setting)
    ,"LIST"
    ,[localize "STR_dui_namelist_icon_priority", localize "STR_dui_namelist_icon_priority_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,[[0, 1], [localize "STR_dui_namelist_icon_priority_setting0", localize "STR_dui_namelist_icon_priority_setting1"], 1]
    ,true
] call CBA_fnc_addSetting;

_curCat = localize "STR_dui_cat_compass";

[
    "diwako_dui_enable_compass"
    ,"CHECKBOX"
    ,[localize "STR_dui_show_compass", localize "STR_dui_show_compass_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,true
    ,false
] call CBA_fnc_addSetting;

[
    QGVAR(show_cardinal_points)
    ,"CHECKBOX"
    ,[localize "STR_dui_radar_show_cardinal_points", localize "STR_dui_radar_show_cardinal_points_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,true
    ,false
] call CBA_fnc_addSetting;

[
    "diwako_dui_enable_compass_dir"
    ,"LIST"
    ,[localize "STR_dui_show_dir", localize "STR_dui_show_dir_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,[
        [0,1,2,3,4],
        [localize "STR_dui_show_dir_opt1",localize "STR_dui_show_dir_opt2",localize "STR_dui_show_dir_opt3",localize "STR_dui_show_dir_opt4",localize "STR_dui_show_dir_opt5"],
        1
    ]
    ,false
] call CBA_fnc_addSetting;

[
    "diwako_dui_dir_showMildot"
    ,"CHECKBOX"
    ,[localize "STR_dui_show_milrad", localize "STR_dui_show_milrad_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,false
    ,false
] call CBA_fnc_addSetting;

[
    QGVAR(leadingZeroes)
    ,"CHECKBOX"
    ,[localize "STR_dui_radar_leading_zeroes", localize "STR_dui_radar_leading_zeroes_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,false
    ,false
] call CBA_fnc_addSetting;

[
    "diwako_dui_dir_size"
    ,"SLIDER"
    ,[localize "STR_dui_dir_size", ""]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,[0, 3, 1.25, 2]
    ,false
    ,{
        [QGVAR(refreshUI),[]] call CBA_fnc_localEvent;
    }
] call CBA_fnc_addSetting;

[
    QGVAR(dir_shadow)
    ,"LIST"
    ,[localize "STR_dui_dir_shadow", ""]
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
] call CBA_fnc_addSetting;

[
    QGVAR(dir_padding)
    ,"SLIDER"
    ,[localize "STR_dui_dir_padding", ""]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,[0, 100, 25, 2]
    ,false
    ,{
        [QGVAR(refreshUI),[]] call CBA_fnc_localEvent;
    }
] call CBA_fnc_addSetting;

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
] call CBA_fnc_addSetting;

[
    "diwako_dui_compassRange"
    ,"SLIDER"
    ,[localize "STR_dui_compass_range", localize "STR_dui_compass_range_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,[DUI_MIN_RANGE, DUI_MAX_RANGE, 35, 0]
    ,false
] call CBA_fnc_addSetting;

[
    QGVAR(compassRangeLimit)
    ,"SLIDER"
    ,[localize "STR_dui_compass_range_limit", localize "STR_dui_compass_range_limit_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,[DUI_MIN_RANGE, DUI_MAX_RANGE, DUI_DEFAULT_MAX_RANGE, 0]
    ,true
] call CBA_fnc_addSetting;

[
    QGVAR(vehicleCompassEnabled)
    ,"CHECKBOX"
    ,[localize "STR_dui_compass_vehicle_enabled", localize "STR_dui_compass_vehicle_enabled_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,false
    ,true
] call CBA_fnc_addSetting;

[
    QGVAR(compassRangeCrew)
    ,"SLIDER"
    ,[localize "STR_dui_compass_crew_range", localize "STR_dui_compass_crew_range_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,[DUI_MIN_VEHICLE_RANGE, DUI_MAX_VEHICLE_RANGE, 500, 0]
    ,false
] call CBA_fnc_addSetting;

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
] call CBA_fnc_addSetting;

[
    "diwako_dui_enable_occlusion"
    ,"CHECKBOX"
    ,[localize "STR_dui_occlusion", localize "STR_dui_occlusion_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,false
    ,false
] call CBA_fnc_addSetting;

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
] call CBA_fnc_addSetting;

[
    QGVAR(occlusion_fade_time)
    ,"SLIDER"
    ,[localize "STR_dui_occlusion_fade_time", localize "STR_dui_occlusion_fade_time_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,[2, 60, 10, 1]
    ,false
] call CBA_fnc_addSetting;

[
    QGVAR(occlusion_fade_in_time)
    ,"SLIDER"
    ,[localize "STR_dui_occlusion_fade_in_time", localize "STR_dui_occlusion_fade_time_in_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,[0, 60, 1, 1]
    ,false
] call CBA_fnc_addSetting;

[
    "diwako_dui_compass_icon_scale"
    ,"SLIDER"
    ,[localize "STR_dui_compass_icon_scale", localize "STR_dui_compass_icon_scale_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,[0.01, 6, 1, 2]
    ,false
] call CBA_fnc_addSetting;

[
    QGVAR(icon_scale_crew)
    ,"SLIDER"
    ,[localize "STR_dui_compass_icon_scale_crew", localize "STR_dui_compass_icon_scale_crew_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,[0.01, 24, 6, 2]
    ,false
] call CBA_fnc_addSetting;

[
    "diwako_dui_compass_opacity"
    ,"SLIDER"
    ,[localize "STR_dui_compass_opacity", ""]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,[0, 1, 1, 2]
    ,false
    ,{
        [QGVAR(refreshUI),[]] call CBA_fnc_localEvent;
    }
] call CBA_fnc_addSetting;

[
    QGVAR(icon_opacity)
    ,"SLIDER"
    ,[localize "STR_dui_compass_icon_opacity", ""]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,[0, 1, 1, 2]
    ,false
] call CBA_fnc_addSetting;

[
    QGVAR(icon_opacity_no_player)
    ,"CHECKBOX"
    ,[localize "STR_dui_compass_icon_opacity_no_player", ""]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,true
    ,false
] call CBA_fnc_addSetting;

[
    "diwako_dui_distanceWarning"
    ,"SLIDER"
    ,[localize "STR_dui_compass_warning", localize "STR_dui_compass_warning_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,[0, 50, 3, 1]
    ,false
] call CBA_fnc_addSetting;

[
    "diwako_dui_compass_hide_alone_group"
    ,"CHECKBOX"
    ,[localize "STR_dui_compass_hide_when_alone", localize "STR_dui_compass_hide_when_alone_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,false
    ,false
] call CBA_fnc_addSetting;

[
    "diwako_dui_compass_hide_blip_alone_group"
    ,"CHECKBOX"
    ,[localize "STR_dui_compass_hide_blip_when_alone", localize "STR_dui_compass_hide_blip_when_alone_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,false
    ,false
] call CBA_fnc_addSetting;

[
    QGVAR(group_by_vehicle)
    ,"CHECKBOX"
    ,[localize "STR_dui_radar_group_by_vehicle", localize "STR_dui_radar_group_by_vehicle_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,false
    ,false
] call CBA_fnc_addSetting;

[
    QGVAR(enable_seat_icons)
    ,"LIST"
    ,[localize "STR_dui_radar_enable_seat_icons", localize "STR_dui_radar_enable_seat_icons_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,[[0, 1, 2], [localize "STR_dui_show_dir_opt1", localize "STR_dui_radar_enable_seat_icons_sameVehicle", localize "STR_dui_show_dir_opt3"], 2]
    ,false
] call CBA_fnc_addSetting;

GVAR(pointers) = [];
if (isClass(configFile >> "CfgPatches" >> "ace_finger")) then {
    #include "include\getPointerStyles.sqf"
    [
        QGVAR(ace_finger)
        ,"CHECKBOX"
        ,["ACE " + (localize "STR_ACE_finger_indicatorColor_name"), localize "STR_ACE_finger_indicatorForSelf_description"]
        ,[CBA_SETTINGS_CAT, _curCat]
        ,true
        ,false
    ] call CBA_fnc_addSetting;
    [
        QGVAR(pointer_style)
        ,"LIST"
        ,[localize "STR_dui_radar_pointer_style", localize "STR_dui_radar_pointer_style_desc"]
        ,[CBA_SETTINGS_CAT, _curCat]
        ,[
            _pointerClasses,
            _pointerNames,
            0
        ]
        ,false
    ] call CBA_fnc_addSetting;
    [
        QGVAR(pointer_color)
        ,"COLOR"
        ,localize "STR_dui_radar_pointer_color"
        ,[CBA_SETTINGS_CAT, _curCat]
        ,[1, 0.5, 0, 1]
        ,false
    ] call CBA_fnc_addSetting;
};

[
    QGVAR(always_show_unit_numbers)
    ,"CHECKBOX"
    ,[localize "STR_dui_radar_always_show_unit_numbers", localize "STR_dui_radar_always_show_unit_numbers_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,false
    ,false
] call CBA_fnc_addSetting;

// todo display to change the position in-game (should reset to center of screen)(0.5,0.5)
// todo keydown or option for ^ (or addAction(resets after use))
// save it in profileNamespace
// + scaling
// + reset per axis

_curCat = localize "STR_dui_cat_namelist";

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
] call CBA_fnc_addSetting;

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
] call CBA_fnc_addSetting;

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
] call CBA_fnc_addSetting;

if (isClass(configFile >> "CfgPatches" >> "diwako_dui_buddy")) then {
    [
        "diwako_dui_namelist_only_buddy_icon"
        ,"CHECKBOX"
        ,[localize "STR_dui_namelist_buddy", localize "STR_dui_namelist_buddy_desc"]
        ,[CBA_SETTINGS_CAT, _curCat]
        ,false
        ,false
    ] call CBA_fnc_addSetting;
} else {
    diwako_dui_namelist_only_buddy_icon = false;
};

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
] call CBA_fnc_addSetting;

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
] call CBA_fnc_addSetting;

[
    "diwako_dui_namelist_text_shadow"
    ,"LIST"
    ,[localize "STR_dui_namelist_text_shadow", ""]
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
] call CBA_fnc_addSetting;

[
    QGVAR(namelist_hideWhenLeader)
    ,"CHECKBOX"
    ,[localize "STR_dui_namelist_hideWhenLeader", localize "STR_dui_namelist_hideWhenLeader_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,false
    ,false
] call CBA_fnc_addSetting;

GVAR(sortNamespace) = [] call CBA_fnc_createNamespace;
GVAR(sortNamespace) setVariable ["main", 4];
GVAR(sortNamespace) setVariable ["red", 0];
GVAR(sortNamespace) setVariable ["green", 1];
GVAR(sortNamespace) setVariable ["blue", 2];
GVAR(sortNamespace) setVariable ["yellow", 3];
GVAR(sortNamespace) setVariable ["PRIVATE", 6];
GVAR(sortNamespace) setVariable ["CORPORAL", 5];
GVAR(sortNamespace) setVariable ["SERGEANT", 4];
GVAR(sortNamespace) setVariable ["LIEUTENANT", 3];
GVAR(sortNamespace) setVariable ["CAPTAIN", 2];
GVAR(sortNamespace) setVariable ["MAJOR", 1];
GVAR(sortNamespace) setVariable ["COLONEL", 0];

[
    QGVAR(sqlFirst)
    ,"CHECKBOX"
    ,[localize "STR_dui_radar_sqlFirst", localize "STR_dui_radar_sqlFirst_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,false
    ,true
] call CBA_fnc_addSetting;

[
    QGVAR(sortType)
    ,"LIST"
    ,[localize "STR_dui_radar_sort", localize "STR_dui_radar_sort_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,[
        ["none", "name", "fireteam", "fireteam2", "rank", "custom"],
        [
            localize "STR_dui_radar_sort_none",
            localize "STR_dui_radar_sort_name",
            localize "STR_dui_radar_sort_fireteam",
            localize "STR_dui_radar_sort_fireteam2",
            localize "STR_dui_radar_sort_rank",
            localize "STR_dui_color_custom"
        ],
        0
    ]
    ,true
] call CBA_fnc_addSetting;

[
    QGVAR(syncGroup)
    ,"CHECKBOX"
    ,[localize "STR_dui_radar_syncGroup", localize "STR_dui_radar_syncGroup_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,false
    ,true
    ,{
        params ["_value"];
        if (_value) exitWith {};
        {
            _x setVariable [QGVAR(syncGroup), nil];
        } forEach allGroups;
    }
] call CBA_fnc_addSetting;

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
] call CBA_fnc_addSetting;

_curCat = localize "STR_dui_cat_layout";

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
] call CBA_fnc_addSetting;

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

if (_tfar) then {
    /* This is a custom event made by DUI not by TFAR!
     * In TFAR the client's game has no idea if the one unit speaking is speaking locally or over radio.
     * The OnSpeak event also appears to be delayed after the onTangent event...
     * This means you only know the unit speaks over radio and not if you can actually hear/receive them.
     * The result is the radio icon appears even if the sender is out of range or
     * sending over a radio you cannot possible receive...
     */
    ["TFAR_event_onTangentRemote", {
        [{
            // params ["_unit", "_radio", "_radioType", "_additional", "_buttonDown"];
            params ["_unit", "", "", "", "_buttonDown"];
            if !(_buttonDown) exitWith {
                // radio button was released but only show radio icon
                if (GVAR(showSpeaking_radioOnly)) exitWith {
                    _unit setVariable [QGVAR(isSpeaking), nil];
                };
                // radio button was released, but unit is still speaking
                if ((_unit getVariable [QGVAR(isSpeaking), 0]) isEqualTo 2) exitWith {
                    _unit setVariable [QGVAR(isSpeaking), 1];
                };
                // radio button was released, but unit is not speaking anymore
                // let OnSpeak event handler deal with it
            };
            _unit setVariable [QGVAR(isSpeaking), 2];
        }, _this, 0.5] call CBA_fnc_waitAndExecute;
    }] call CBA_fnc_addEventHandler;
};
if (_acre) then {
    {
        [_x, {
            params ["_unit"];
            _unit setVariable [QGVAR(isSpeaking), nil];
        }] call CBA_fnc_addEventHandler;
    } forEach ["acre_stoppedSpeaking", "acre_remoteStoppedSpeaking"];

    {
        [_x, {
            params ["_unit", ["_onRadio", false]];
            // _onRadio is either a boolean or an integer
            // handle remoteStartedSpeaking integers
            if (_onRadio isEqualType 0) then {
                _onRadio = switch (_onRadio) do {
                    // handle specific acre speaking types
                    case 2; // unknown
                    case 3; // intercom
                    case 4; // spectator
                    case 6: { false }; // zeus

                    case 1; // radio
                    case 5: { true }; // god
                    default { false }; // future features
                };
            };
            if (GVAR(showSpeaking_radioOnly) && {!_onRadio}) exitWith {};
            _unit setVariable [QGVAR(isSpeaking), [1, 2] select _onRadio];
        }] call CBA_fnc_addEventHandler;
    } forEach ["acre_remoteStartedSpeaking", "acre_startedSpeaking"];
};

ADDON = true;
