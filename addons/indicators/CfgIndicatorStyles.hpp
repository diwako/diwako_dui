class diwako_dui_indicator_style {
    class standard {
        name = "$STR_dui_indicators_indicator_standard";

        indicator = "\A3\ui_f\data\igui\cfg\cursors\select_ca.paa";

        leader = "\A3\ui_f\data\igui\cfg\cursors\leader_ca.paa";
        medic = "\A3\ui_f\data\igui\cfg\cursors\unitHealer_ca.paa";
        buddy = "\A3\ui_f_curator\Data\Displays\RscDisplayCurator\modeUnits_ca.paa";
    };

    class square:standard {
        name = "$STR_dui_indicators_indicator_square";

        indicator = QPATHTO_T(UI\indicators\square.paa);
    };

    class diamond:standard {
        name = "$STR_dui_indicators_indicator_diamond";

        indicator = QPATHTO_T(UI\indicators\diamond.paa);
    };
    class circle:standard {
        name = "$STR_dui_indicators_indicator_circle";

        indicator = QPATHTO_T(UI\indicators\circle.paa);
    };
};
