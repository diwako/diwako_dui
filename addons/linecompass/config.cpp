#include "script_component.hpp"
class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"diwako_dui_main"};
        author = "joko // Jonas";
        VERSION_CONFIG;
        license = "https://www.bohemia.net/community/licenses/arma-public-license-share-alike";
    };
};

#include "CfgUIGrids.hpp"
#include "CfgEventHandlers.hpp"
#include "CfgRscTitles.hpp"
