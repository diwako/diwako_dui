#include "script_component.hpp"
class CfgPatches {
    class ADDON {
        name = COMPONENT;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_main"};
        author[] = {"diwako"};
        authorUrl = "https://github.com/diwako/diwako_dui";
        license = "https://www.bohemia.net/community/licenses/arma-public-license-share-alike";
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgColorStyles.hpp"
#include "CfgIconStyles.hpp"
