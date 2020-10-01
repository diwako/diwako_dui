#define COMPONENT nametags
#define COMPONENT_BEAUTIFIED Nametags
#include "\z\diwako_dui\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_NAMETAGS
    #define DEBUG_MODE_FULL
#endif
    #ifdef DEBUG_SETTINGS_NAMETAGS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_NAMETAGS
#endif

#include "\z\diwako_dui\addons\main\script_macros.hpp"

#define IDC_NAMETAG 1337006

#define POS_X 0.5 - (pixelW * 128)
#define POS_Y 0.5 - pixelH
#define POS_W pixelW * 256
#define POS_H pixelH * 64
#define GET_POS_X profileNamespace getVariable ['igui_diwako_dui_nametags_x', POS_X]
#define GET_POS_Y profileNamespace getVariable ['igui_diwako_dui_nametags_y', POS_Y]
#define GET_POS_W profileNamespace getVariable ['igui_diwako_dui_nametags_w', POS_W]
#define GET_POS_H profileNamespace getVariable ['igui_diwako_dui_nametags_h', POS_H]

/* ResetSettings
    profileNamespace setVariable ['igui_diwako_dui_nametags_x', nil];
    profileNamespace setVariable ['igui_diwako_dui_nametags_y', nil];
    profileNamespace setVariable ['igui_diwako_dui_nametags_w', nil];
    profileNamespace setVariable ['igui_diwako_dui_nametags_h', nil];
*/
