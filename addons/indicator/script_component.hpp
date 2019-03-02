#define COMPONENT indicator
#include "\z\diwako_dui\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_INDICATOR
    #define DEBUG_MODE_FULL
#endif
    #ifdef DEBUG_SETTINGS_INDICATOR
    #define DEBUG_SETTINGS DEBUG_SETTINGS_INDICATOR
#endif

#define NIGHT_ALPHA 0.15
#define DAY_ALPHA 0.45

#include "\z\diwako_dui\addons\main\script_macros.hpp"
