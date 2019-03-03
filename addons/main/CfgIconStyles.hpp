class diwako_dui_icon_style
{
    class standard
    {
        name = "$STR_dui_color_standard";

        sql = "\A3\ui_f\data\map\vehicleicons\iconManLeader_ca.paa";
        medic = "\A3\ui_f\data\map\vehicleicons\iconManMedic_ca.paa";
        auto_rifleman = "\A3\ui_f\data\map\vehicleicons\iconManMG_ca.paa";
        at_gunner = "\A3\ui_f\data\map\vehicleicons\iconManAT_ca.paa";
        engineer = "\A3\ui_f\data\map\vehicleicons\iconManEngineer_ca.paa";
        explosive_specialist = "\A3\ui_f\data\map\vehicleicons\iconManExplosive_ca.paa";
        rifleman = "\A3\ui_f\data\map\vehicleicons\iconMan_ca.paa";
        vehicle_cargo = "a3\ui_f\data\igui\cfg\commandbar\imagecargo_ca.paa";
        vehicle_driver = "a3\ui_f\data\igui\cfg\commandbar\imagedriver_ca.paa";
        fire_from_vehicle = "a3\ui_f\data\igui\cfg\simpletasks\types\rifle_ca.paa";
        vehicle_gunner = "a3\ui_f\data\igui\cfg\commandbar\imagegunner_ca.paa";
        vehicle_commander = "a3\ui_f\data\igui\cfg\commandbar\imagecommander_ca.paa";

        rank_private = "a3\ui_f\data\GUI\Cfg\Ranks\private_gs.paa";
        rank_corporal = "a3\ui_f\data\GUI\Cfg\Ranks\corporal_gs.paa";
        rank_sergeant = "a3\ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
        rank_lieutenant = "a3\ui_f\data\GUI\Cfg\Ranks\lieutenant_gs.paa";
        rank_captain = "a3\ui_f\data\GUI\Cfg\Ranks\captain_gs.paa";
        rank_major = "a3\ui_f\data\GUI\Cfg\Ranks\major_gs.paa";
        rank_colonel = "a3\ui_f\data\GUI\Cfg\Ranks\colonel_gs.paa";

        buddy = "a3\ui_f_curator\Data\Displays\RscDisplayCurator\modeUnits_ca.paa";
        buddy_compass = QPATHTO_T(UI\icon_styles\standard\buddy_compass);
    };

    class terry:standard
    {
        name = "$STR_dui_icon_terry";

        sql = QPATHTO_T(UI\icon_styles\terry\iconManLeader_ca.paa);
        medic = QPATHTO_T(UI\icon_styles\terry\iconManMedic_ca.paa);
        auto_rifleman = QPATHTO_T(UI\icon_styles\terry\iconManMG_ca.paa);
        at_gunner = QPATHTO_T(UI\icon_styles\terry\iconManAT_ca.paa);
        engineer = QPATHTO_T(UI\icon_styles\terry\iconManEngineer_ca.paa);
        explosive_specialist = QPATHTO_T(UI\icon_styles\terry\iconManExplosive_ca.paa);
        rifleman = QPATHTO_T(UI\icon_styles\terry\iconMan_ca.paa);

        buddy_compass = QPATHTO_T(UI\icon_styles\terry\buddy_compass.paa);
    };

    class nato:standard
    {
        name = "$STR_dui_icon_nato";

        sql = QPATHTO_T(UI\icon_styles\nato\GAR_iconManLeader_ca.paa);
        medic = QPATHTO_T(UI\icon_styles\nato\GAR_iconManMedic_ca.paa);
        auto_rifleman = QPATHTO_T(UI\icon_styles\nato\GAR_iconManMG_ca.paa);
        at_gunner = QPATHTO_T(UI\icon_styles\nato\GAR_iconManAT_ca.paa);
        engineer = QPATHTO_T(UI\icon_styles\nato\GAR_iconManEngineer_ca.paa);
        explosive_specialist = QPATHTO_T(UI\icon_styles\nato\GAR_iconManExplosive_ca.paa);
    };

    class clones:standard
    {
        name = "$STR_dui_icon_clones";

        sql = QPATHTO_T(UI\icon_styles\clones\icon_leader.paa);
        medic = QPATHTO_T(UI\icon_styles\clones\icon_medic.paa);
        auto_rifleman = QPATHTO_T(UI\icon_styles\clones\icon_mg.paa);
        at_gunner = QPATHTO_T(UI\icon_styles\clones\icon_at.paa);
        engineer = QPATHTO_T(UI\icon_styles\clones\icon_engineer.paa);
        explosive_specialist = QPATHTO_T(UI\icon_styles\clones\icon_grenadier.paa);
        rifleman = QPATHTO_T(UI\icon_styles\clones\icon_rifleman.paa);
    };
};