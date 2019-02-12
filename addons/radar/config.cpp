#include "script_component.hpp"
class CfgPatches {
  class ADDON {
    name = COMPONENT;
    units[] = {};
    weapons[] = {};
    requiredVersion = REQUIRED_VERSION;
    requiredAddons[] = {"diwako_dui_main"};
    author = "Diwako";
    VERSION_CONFIG;
    license = "https://www.bohemia.net/community/licenses/arma-public-license-share-alike";
  };
};

#include "CfgEventHandlers.hpp"
#include "CfgUIGrids.hpp"
#include "CfgCompassStyles.hpp"
#include "gui.hpp"
