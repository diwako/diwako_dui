#define REQUIRED_VERSION 1.88
#define VERSION "1.0.0"

class CfgPatches {
    class diwako_dui {
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "cba_common"
        };
        author[] = {"diwako"};
        authorUrl = "https://github.com/diwako/diwako_dui";
        version = VERSION;
        versionStr = VERSION;
        license = "https://www.bohemia.net/community/licenses/arma-public-license-share-alike";
    };
};

#include "script_component.hpp"
#include "CfgFunctions.hpp"
#include "CfgUIGrids.hpp"
#include "gui.hpp"
#include "compass_style.hpp"
#include "icon_style.hpp"
#include "color_style.hpp"

class Extended_PreInit_EventHandlers {
    class diwako_dui {
        init = "call compile preprocessFileLineNumbers 'diwako_dui\functions\fn_preinit.sqf'";
    };
};
