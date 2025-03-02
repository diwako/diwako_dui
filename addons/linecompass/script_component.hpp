#define COMPONENT linecompass
#define COMPONENT_BEAUTIFIED Line Compass
#include "\z\diwako_dui\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
#define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_LINECOMPASS
    #define DEBUG_MODE_FULL
#endif
#ifdef DEBUG_SETTINGS_LINECOMPASS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_LINECOMPASS
#endif


#include "\z\diwako_dui\addons\main\script_macros.hpp"

// UI Based Macros
#define PYN 108
#define PX(X) ((X)/PYN*safeZoneH/(4/3))
#define PY(Y) ((Y)/PYN*safeZoneH)

#define POS_X 0.5 - PX(46.25)
#define POS_H PY(5)
#define POS_Y safeZoneY
#define POS_W PX(92.5)

#define GET_POS_X profileNamespace getVariable ['igui_diwako_dui_linecompass_x', POS_X]
#define GET_POS_Y profileNamespace getVariable ['igui_diwako_dui_linecompass_y', POS_Y]
#define GET_POS_W profileNamespace getVariable ['igui_diwako_dui_linecompass_w', POS_W]
#define GET_POS_H profileNamespace getVariable ['igui_diwako_dui_linecompass_h', POS_H]

#define CONTAINER_IDC 7000
#define NEEDLE_IDC 7001
#define HOLDER_IDC 7100
#define LINE_IDC_START 7101
#define BEARING_IDC_START 7301
