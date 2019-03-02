#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"

#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#define CBA_SETTINGS_CAT localize "STR_dui_mod" + " - Main"

GVAR(inFeatureCamera) = false;

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
    ,{
        [QGVAR(refreshUI),[]] call CBA_fnc_localEvent;
    }
] call CBA_Settings_fnc_init;

#include "include\getIconStyles.sqf"
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

#include "include\getColorStyles.sqf"
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

[
    QGVAR(hide_ui_by_default)
    ,"CHECKBOX"
    ,[localize "STR_dui_hide_ui_by_default", localize "STR_dui_hide_ui_by_default_desc"]
    ,[CBA_SETTINGS_CAT, _curCat]
    ,false
    ,false
    ,{
        params ["_value"];
        GVAR(toggled_off) = _value;
    }
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

if !(hasInterface) exitWith {};

GVAR(radioModSpectator) = configFile call {
    if (isClass (_this >> "tfar_core")) exitWith { {_player getVariable ["TFAR_forceSpectator", false]} };
    if (isClass (_this >> "CfgPatches" >> "acre_main")) exitWith { {ACRE_IS_SPECTATOR} };
    {false};
};

// cba eh for hiding the hud when in certain camera modes
["featureCamera", {
    params ["_player", "_featureCamera"];
    GVAR(inFeatureCamera) = !(_featureCamera isEqualTo "");
}, true] call CBA_fnc_addPlayerEventHandler;

// player remote controls another unit or changes avatar
// mainly used for the change in avatar / switch unit part as displays will be closed
["unit", {
    params ["_newPlayerUnit", "_oldPlayerUnit"];
    [QGVAR(refreshUI),[]] call CBA_fnc_localEvent;
}, true] call CBA_fnc_addPlayerEventHandler;

if (isClass (configfile >> "CfgPatches" >> "ace_nametags")) then {
    ["CBA_SettingChanged", {
        params ["_setting", "_value"];
        switch (_setting) do {
            case "ace_nametags_nametagColorMain": {
                EGVAR(main,colors_ace) setVariable ["main_compass", _value select [0, 3]];
                EGVAR(main,colors_ace) setVariable ["main", [(_value select 0) * 255,(_value select 1) * 255,(_value select 2) * 255] call EFUNC(main,toHex)];
            };
            case "ace_nametags_nametagColorRed": {
                EGVAR(main,colors_ace) setVariable ["red_compass", _value select [0, 3]];
                EGVAR(main,colors_ace) setVariable ["red", [(_value select 0) * 255,(_value select 1) * 255,(_value select 2) * 255] call EFUNC(main,toHex)];
            };
            case "ace_nametags_nametagColorGreen": {
                EGVAR(main,colors_ace) setVariable ["green_compass", _value select [0, 3]];
                EGVAR(main,colors_ace) setVariable ["green", [(_value select 0) * 255,(_value select 1) * 255,(_value select 2) * 255] call EFUNC(main,toHex)];
            };
            case "ace_nametags_nametagColorBlue": {
                EGVAR(main,colors_ace) setVariable ["blue_compass", _value select [0, 3]];
                EGVAR(main,colors_ace) setVariable ["blue", [(_value select 0) * 255,(_value select 1) * 255,(_value select 2) * 255] call EFUNC(main,toHex)];
            };
            case "ace_nametags_nametagColorYellow": {
                EGVAR(main,colors_ace) setVariable ["yellow_compass", _value select [0, 3]];
                EGVAR(main,colors_ace) setVariable ["yellow", [(_value select 0) * 255,(_value select 1) * 255,(_value select 2) * 255] call EFUNC(main,toHex)];
            };
            default { };
        };
    }] call CBA_fnc_addEventHandler;
};

// keybind to toggle whole UI
[CBA_SETTINGS_CAT, "diwako_dui_button_toggle_ui", localize "STR_dui_key_toggle", {
    GVAR(toggled_off) = !GVAR(toggled_off);
    [QGVAR(hudToggled), [GVAR(toggled_off)]] call CBA_fnc_localEvent;
    true
},
{false},
[DIK_MULTIPLY, [false, true, false]], false] call CBA_fnc_addKeybind;

// hold to show/hide UI
[CBA_SETTINGS_CAT, QGVAR(button_hold_ui), localize "STR_dui_button_hold_ui", {
    GVAR(toggled_off) = !GVAR(toggled_off);
    if (GVAR(toggled_off)) then {
        [QGVAR(hudToggled), [GVAR(toggled_off)]] call CBA_fnc_localEvent;
    };
    true
},
{
    GVAR(toggled_off) = !GVAR(toggled_off);
    if (GVAR(toggled_off)) then {
        [QGVAR(hudToggled), [GVAR(toggled_off)]] call CBA_fnc_localEvent;
    };
    true
}] call CBA_fnc_addKeybind;

ADDON = true;
