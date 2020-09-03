#include "\z\diwako_dui\addons\main\RscCommon.hpp"

class RscTitles {
    class ADDON {
        idd = -1;
        movingEnable = "true";
        duration = 9999999;
        fadein = 1;
        fadeout = 1;
        onLoad = "uiNamespace setVariable ['diwako_dui_RscNametags',_this select 0];";
        class ControlsBackground {
            class Nametag: ctrlStructuredText {
                idc = IDC_NAMETAG;
                moving = 1;
                x = QUOTE(GET_POS_X);
                y = QUOTE(GET_POS_Y);
                h = QUOTE(GET_POS_H);
                w = QUOTE(GET_POS_W);
                colorBackground[] = {0,0,0,0};
                colorText[] = {1,1,1,1};
                text = "";
                shadow = 2;
            };
        };
    };
};
