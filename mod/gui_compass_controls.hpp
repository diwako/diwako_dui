class ControlsBackground
{
    class compass
    {
        idc = IDC_COMPASS;
        moving = 1;
        type = 0;
        style = 48;
        x = "0.5 - (pixelW * 64)";
        y = "safeZoneY + safeZoneH - (pixelH * 138)";
        w = "pixelW * 128"; // * 3 / 4;
        h = "pixelH * 128"; // * 4 / 3;
        font = "EtelkaNarrowMediumPro";
        sizeEx = 1;
        colorBackground[] = {1,1,1,0};
        colorText[] = {1,1,1,1};
        text = "";
        lineSpacing = 1;
    };

    class direction:ctrlStructuredText
    {
        idc = IDC_DIRECTION;
        moving = 1;
        x = "0.5 - (pixelW * 64)";
        y = "safeZoneY + safeZoneH - (pixelH * 195)";
        w = "pixelW * 128";
        h = "pixelH * 70";
        font = "EtelkaNarrowMediumPro";
        colorBackground[] = {0,0,0,0};
        colorText[] = {1,1,1,1};
        text = "";
        lineSpacing = 1;
        shadow = 2;
    };
};

class controls
{
    class group:RscControlsGroupNoScrollbars
    {
        idc = IDC_COMPASS_CTRLGRP;
        x = "0.5 - (pixelW * 64)"; //64
        y = "safeZoneY + safeZoneH - (pixelH * 138)";
        w = "pixelW * 128"; // * 3 / 4;
        h = "pixelH * 128"; // * 4 / 3;
        shadow=0;

        class VScrollbar
        {

        };

        class HScrollbar
        {

        };

        class ScrollBar
        {

        };
        class Controls
        {

        };
    };
};