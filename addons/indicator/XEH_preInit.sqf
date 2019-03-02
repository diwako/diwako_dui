#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"

#define CBA_SETTINGS_CAT localize "STR_dui_mod" + " - Indicators"

[
    QGVAR(show)
    ,"CHECKBOX"
    ,[localize "STR_dui_show_indicators", localize "STR_dui_show_indicators_desc"]
    ,CBA_SETTINGS_CAT
    ,true
] call CBA_Settings_fnc_init;

ADDON = true;
