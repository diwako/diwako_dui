#include "script_component.hpp"
class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_main"};
        author = "diwako";
        url = "https://github.com/diwako/diwako_dui";
        authorUrl = "https://github.com/diwako/diwako_dui";
        license = "https://www.bohemia.net/community/licenses/arma-public-license-share-alike";
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgColorStyles.hpp"
#include "CfgIconStyles.hpp"
