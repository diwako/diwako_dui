class CfgUIGrids {
    class IGUI {
        class Presets {
            class Arma3 {
                class Variables {
                    ADDON[] = {
                        {
                            QUOTE(POS_X),
                            QUOTE(POS_Y),
                            QUOTE(POS_W),
                            QUOTE(POS_H)
                        },
                        "(((safezoneW / safezoneH) min 1.2) / 40)",
                        "((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
                    };
                };
            };
        };

        class Variables {
            class ADDON {
                displayName = "$STR_dui_addon_linecompass";
                description = "$STR_dui_linecompass_UIGrids_desc";
                preview = "#(argb,8,8,3)color(0,0,0,0.75)";
                saveToProfile[] = {0,1,2,3};
                canResize = 0;
            };
        };
    };
};
