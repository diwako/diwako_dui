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
#include "gui.hpp"
#include "compass_style.hpp"
#include "icon_style.hpp"
#include "color_style.hpp"

class Extended_PreInit_EventHandlers {
    class diwako_dui {
        init = "call compile preprocessFileLineNumbers 'diwako_dui\functions\fn_preinit.sqf'";
    };
};

class CfgFontFamilies {
    class Bombardier {
        fonts[] = {"diwako_dui\UI\fonts\bombardier\Bombardier6","diwako_dui\UI\fonts\bombardier\Bombardier7","diwako_dui\UI\fonts\bombardier\Bombardier8","diwako_dui\UI\fonts\bombardier\Bombardier9","diwako_dui\UI\fonts\bombardier\Bombardier10","diwako_dui\UI\fonts\bombardier\Bombardier11","diwako_dui\UI\fonts\bombardier\Bombardier12","diwako_dui\UI\fonts\bombardier\Bombardier13","diwako_dui\UI\fonts\bombardier\Bombardier14","diwako_dui\UI\fonts\bombardier\Bombardier15","diwako_dui\UI\fonts\bombardier\Bombardier16","diwako_dui\UI\fonts\bombardier\Bombardier17","diwako_dui\UI\fonts\bombardier\Bombardier18","diwako_dui\UI\fonts\bombardier\Bombardier19","diwako_dui\UI\fonts\bombardier\Bombardier20","diwako_dui\UI\fonts\bombardier\Bombardier21","diwako_dui\UI\fonts\bombardier\Bombardier22","diwako_dui\UI\fonts\bombardier\Bombardier23","diwako_dui\UI\fonts\bombardier\Bombardier24","diwako_dui\UI\fonts\bombardier\Bombardier25","diwako_dui\UI\fonts\bombardier\Bombardier26","diwako_dui\UI\fonts\bombardier\Bombardier27","diwako_dui\UI\fonts\bombardier\Bombardier28","diwako_dui\UI\fonts\bombardier\Bombardier29","diwako_dui\UI\fonts\bombardier\Bombardier30","diwako_dui\UI\fonts\bombardier\Bombardier31","diwako_dui\UI\fonts\bombardier\Bombardier32","diwako_dui\UI\fonts\bombardier\Bombardier33","diwako_dui\UI\fonts\bombardier\Bombardier34","diwako_dui\UI\fonts\bombardier\Bombardier35","diwako_dui\UI\fonts\bombardier\Bombardier36","diwako_dui\UI\fonts\bombardier\Bombardier37","diwako_dui\UI\fonts\bombardier\Bombardier38","diwako_dui\UI\fonts\bombardier\Bombardier39","diwako_dui\UI\fonts\bombardier\Bombardier40"};
        spaceWidth = 0.7;
        spacing = 0.13;
	};
};