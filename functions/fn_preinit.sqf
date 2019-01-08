#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "../script_component.hpp"
#define CBA_SETTINGS_CAT "Diwako UI"

diwako_dui_group = [];
diwako_dui_compass_pfHandle = -1;
diwako_dui_namebox_lists = [];
diwako_dui_toggled_off = false;

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
    ,["Font", "Which font should be used?"]
    ,[CBA_SETTINGS_CAT, "General"]
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
    ,["Icon Style", "Which icon style should be used?"]
    ,[CBA_SETTINGS_CAT, "General"]
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
    ,["Color Scheme", "Which color scheme should be used?"]
    ,[CBA_SETTINGS_CAT, "General"]
    ,[
        _colorStyles select 1,
        _colorStyles select 0,
        0
    ]
    ,false
] call CBA_Settings_fnc_init;

// todo keybind
[
    "diwako_dui_enable_compass"
    ,"CHECKBOX"
    ,["Show compass", "Shows compass and unit markers on it"]
    ,[CBA_SETTINGS_CAT, "Compass"]
    ,true
    ,false
] call CBA_Settings_fnc_init;

[
    "diwako_dui_enable_compass_dir"
    ,"CHECKBOX"
    ,["Show Bearing", "Shows bearing above the compass, compass it self needs to be enabled!"]
    ,[CBA_SETTINGS_CAT, "Compass"]
    ,true
    ,false
] call CBA_Settings_fnc_init;

[
    "diwako_dui_dir_showMildot"
    ,"CHECKBOX"
    ,["Show bearing also in miliradians", "Shows miliradians next to the regular bearing"]
    ,[CBA_SETTINGS_CAT, "Compass"]
    ,false
    ,false
] call CBA_Settings_fnc_init;

private _compassStyles = [] call diwako_dui_fnc_getCompassStyles;
[
    "diwako_dui_compass_style"
    ,"LIST"
    ,["Compass Style", "Which compass style should be used?"]
    ,[CBA_SETTINGS_CAT, "Compass"]
    ,[
        _compassStyles select 1,
        _compassStyles select 0,
        0
    ]
    ,false
] call CBA_Settings_fnc_init;

// todo keybind

[
    "diwako_dui_compassRange"
    ,"SLIDER"
    ,["Compas Range", "How far should players see units in the same group in meters"]
    ,[CBA_SETTINGS_CAT, "Compass"]
    ,[DUI_MIN_RANGE, DUI_MAX_RANGE, 35, 0]
    ,false
] call CBA_Settings_fnc_init;

[
    "diwako_dui_compassRefreshrate"
    ,"SLIDER"
    ,["Refresh Rate", "How fast should the compass render? Value in seconds, 0 means each frame! Set at your own peril!"]
    ,[CBA_SETTINGS_CAT, "Compass"]
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

// todo display to change the position in-game (should reset to center of screen)(0.5,0.5)
// todo keydown or option for ^ (or addAction(resets after use))
// save it in profileNamespace
// + scaling
// + reset per axis

[
    "diwako_dui_namelist"
    ,"CHECKBOX"
    ,["Show Names", "Shows a list of names of units currently in the same group"]
    ,[CBA_SETTINGS_CAT, "Name List"]
    ,true
    ,false
] call CBA_Settings_fnc_init;

[
    "diwako_dui_namelist_size"
    ,"SLIDER"
    ,["Text Size", "Size of the names"]
    ,[CBA_SETTINGS_CAT, "Name List"]
    ,[0.5, 1.75, 1, 2]
    ,false
] call CBA_Settings_fnc_init;


// keybind to toggle whole UI
[CBA_SETTINGS_CAT, "diwako_dui_button_toggle_ui", "Toggle UI on and off", {
    diwako_dui_toggled_off = !diwako_dui_toggled_off;
    true
},
{false},
[DIK_MULTIPLY, [false, true, false]], false] call CBA_fnc_addKeybind;

// keybinds for zooming
[CBA_SETTINGS_CAT, "diwako_dui_button_increase_range", "Increase Range", {
    [true] call diwako_dui_fnc_rangeButton;
    true
},
{false},
[DIK_NUMPADPLUS, [false, true, false]], false] call CBA_fnc_addKeybind;

[CBA_SETTINGS_CAT, "diwako_dui_button_decrease_range", "Decrease Range", {
    [false] call diwako_dui_fnc_rangeButton;
    true
},
{false},
[DIK_NUMPADMINUS, [false, true, false]], false] call CBA_fnc_addKeybind;