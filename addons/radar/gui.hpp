#include "RscCommon.hpp"

class diwako_dui_DialogCompass {
    idd = -1;
    movingEnable = 1;
    duration = 9999999;
    fadein = 0;
    fadeout = 0;
    onLoad = "uiNamespace setVariable [""diwako_dui_DialogCompass"",_this select 0];";
    //onUnload = "[] call diwako_dui_dialogClosedEH";

    #include "gui_compass_controls.hpp"
};

class diwako_dui_DialogNameBox {
    idd = -1;
    movingEnable = 1;
    duration = 9999999;
    fadein = 0;
    fadeout = 0;
    onLoad = "uiNamespace setVariable [""diwako_dui_DialogNameBox"",_this select 0];";
    //onUnload = "[] call diwako_dui_dialogClosedEH";

    #include "gui_namebox_controls.hpp"
};

class RscTitles {
    class diwako_dui_RscCompass {
        idd = -1;
        movingEnable = "true";
        duration = 9999999;
        fadein = 0;
        fadeout = 0;
        onLoad = "uiNamespace setVariable [""diwako_dui_RscCompass"",_this select 0];";

        #include "gui_compass_controls.hpp"
    };

    class diwako_dui_RscNameBox {
        idd = -1;
        movingEnable = "true";
        duration = 9999999;
        fadein = 0;
        fadeout = 0;
        onLoad = "uiNamespace setVariable [""diwako_dui_RscNameBox"",_this select 0];";

        #include "gui_namebox_controls.hpp"
    };
};
