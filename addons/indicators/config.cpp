#include "script_component.hpp"
class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"diwako_dui_main","diwako_dui_radar"};
        author = "BrettMayson";
        VERSION_CONFIG;
        license = "https://www.bohemia.net/community/licenses/arma-public-license-share-alike";
    };
};

class CfgInGameUI {
    class Cursor {
        select = "#(argb,1,1,1)color(0,0,0,0)";
        outArrow = "#(argb,1,1,1)color(0,0,0,0)";
        leader = "#(argb,1,1,1)color(0,0,0,0)";
        // mission = "#(argb,1,1,1)color(0,0,0,0)";
        unitBleeding = "#(argb,1,1,1)color(0,0,0,0)";
        unitInjured = "#(argb,1,1,1)color(0,0,0,0)";
        unitHealer = "#(argb,1,1,1)color(0,0,0,0)";
        unitUnconscious = "#(argb,1,1,1)color(0,0,0,0)";
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgIndicatorStyles.hpp"
