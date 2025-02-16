#define COMPONENT linecompass
#define COMPONENT_BEAUTIFIED Line Compass
#include "\z\diwako_dui\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
#define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_INDICATORS
    #define DEBUG_MODE_FULL
#endif
    #ifdef DEBUG_SETTINGS_INDICATORS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_INDICATORS
#endif


#include "\z\diwako_dui\addons\main\script_macros.hpp"

// UI Based Macros
#define PYN 108
#define PX(X) ((X)/PYN*safeZoneH/(4/3))
#define PY(Y) ((Y)/PYN*safeZoneH)

#define POS_X 0.5 - PX(46.25)
#define POS_H PY(5)
#define POS_Y safeZoneY - POS_H
#define POS_W PX(92.5)

#define GET_POS_X profileNamespace getVariable ['igui_diwako_dui_linecompass_x', POS_X]
#define GET_POS_Y profileNamespace getVariable ['igui_diwako_dui_linecompass_y', POS_Y]
#define GET_POS_W profileNamespace getVariable ['igui_diwako_dui_linecompass_w', POS_W]
#define GET_POS_H profileNamespace getVariable ['igui_diwako_dui_linecompass_h', POS_H]
