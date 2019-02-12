#define COMPONENT radar
#include "\z\diwako_dui\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define CBA_DEBUG_SYNCHRONOUS
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_RADAR
  #define DEBUG_MODE_FULL
#endif
#ifdef DEBUG_SETTINGS_RADAR
  #define DEBUG_SETTINGS DEBUG_SETTINGS_RADAR
#endif

// DEV stuff
#define DUI_RECOMPILE             0
#define DUI_DEBUG                 0

// UI values
#define IDC_COMPASS               1337001
#define IDC_DIRECTION             1337002
#define IDC_COMPASS_CTRLGRP       1337003
#define IDC_NAMEBOX               1337004
#define IDC_NAMEBOX_CTRLGRP       1337005
#define DUI_128PX                 (128 * (missionNamespace getVariable ['diwako_dui_hudScaling', 1]))

// Script values
#define DUI_MAX_RANGE             50
#define DUI_MIN_RANGE             15

#define DUI_SQL                   "a3\ui_f\data\map\vehicleicons\iconManLeader_ca.paa"
#define DUI_MEDIC                 "a3\ui_f\data\map\vehicleicons\iconManMedic_ca.paa"
#define DUI_AUTO_RIFLEMAN         "a3\ui_f\data\map\vehicleicons\iconManMG_ca.paa"
#define DUI_AT_GUNNER             "a3\ui_f\data\map\vehicleicons\iconManAT_ca.paa"
#define DUI_ENGINEER              "a3\ui_f\data\map\vehicleicons\iconManEngineer_ca.paa"
#define DUI_EXPLOSIVE_SPECIALIST  "a3\ui_f\data\map\vehicleicons\iconManExplosive_ca.paa"
#define DUI_RIFLEMAN              "a3\ui_f\data\map\vehicleicons\iconMan_ca.paa"
#define DUI_VEHICLE_CARGO         "a3\ui_f\data\igui\cfg\commandbar\imagecargo_ca.paa"
#define DUI_VEHICLE_DRIVER        "a3\ui_f\data\igui\cfg\commandbar\imagedriver_ca.paa"
#define DUI_FIRE_FROM_VEHICLE     "a3\ui_f\data\igui\cfg\simpletasks\types\rifle_ca.paa"
#define DUI_VEHICLE_GUNNER        "a3\ui_f\data\igui\cfg\commandbar\imagegunner_ca.paa"
#define DUI_VEHICLE_COMMANDER     "a3\ui_f\data\igui\cfg\commandbar\imagecommander_ca.paa"
#define DUI_RANK_PRIVATE          "a3\ui_f\data\GUI\Cfg\Ranks\private_gs.paa"
#define DUI_RANK_CORPORAL         "a3\ui_f\data\GUI\Cfg\Ranks\corporal_gs.paa"
#define DUI_RANK_SERGEANT         "a3\ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa"
#define DUI_RANK_LIEUTENANT       "a3\ui_f\data\GUI\Cfg\Ranks\lieutenant_gs.paa"
#define DUI_RANK_CAPTAIN          "a3\ui_f\data\GUI\Cfg\Ranks\captain_gs.paa"
#define DUI_RANK_MAJOR            "a3\ui_f\data\GUI\Cfg\Ranks\major_gs.paa"
#define DUI_RANK_COLONEL          "a3\ui_f\data\GUI\Cfg\Ranks\colonel_gs.paa"
#define DUI_BUDDY                 "a3\ui_f_curator\Data\Displays\RscDisplayCurator\modeUnits_ca.paa"
#define DUI_BUDDY_COMPASS         "z\diwako_dui\addons\main\UI\icon_styles\standard\buddy_compass"

#include "\z\diwako_dui\addons\main\script_macros.hpp"