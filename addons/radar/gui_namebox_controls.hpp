class ControlsBackground
{
    class box:RscObject
    {
        idc = IDC_NAMEBOX;
        moving = 1;
        x = "0.5 + (pixelW * 74)";
        y = "safeZoneY + safeZoneH - (pixelH * 138)";
        w = "(0.5 - (pixelW * 74)) + safeZoneW";
        h = "pixelH * 138";
        colorBackground[] = {0,0,0,0};
    };
};

class controls
{
    class names:RscControlsGroupNoScrollbars
    {
        idc = IDC_NAMEBOX_CTRLGRP;
        x = "0.5 + (pixelW * 74)";
        y = "safeZoneY + safeZoneH - (pixelH * 138)";
        w = "(0.5 - (pixelW * 74)) + safeZoneW";
        h = "pixelH * 138";
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