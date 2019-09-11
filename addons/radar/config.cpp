#include "script_component.hpp"
class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"diwako_dui_main"};
        author[] = {"diwako"};
        license = "https://www.bohemia.net/community/licenses/arma-public-license-share-alike";
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgUIGrids.hpp"
#include "CfgCompassStyles.hpp"
#include "CfgPointerStyles.hpp"
#include "gui.hpp"
