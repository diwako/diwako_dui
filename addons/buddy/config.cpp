#include "script_component.hpp"
    class CfgPatches {
        class ADDON {
            name = COMPONENT_NAME;
            units[] = {};
            weapons[] = {};
            requiredVersion = REQUIRED_VERSION;
            requiredAddons[] = {"diwako_dui_main"};
            author = "Diwako";
            VERSION_CONFIG;
        };
    };


#include "CfgEventHandlers.hpp"
