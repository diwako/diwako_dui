//diwako_dui script macros
#include "\x\cba\addons\main\script_macros_common.hpp"
#define DFUNC(var1) TRIPLES(ADDON,fnc,var1)
#ifdef DISABLE_COMPILE_CACHE
  #undef PREP
  #define PREP(fncName) DFUNC(fncName) = compileScript [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf)]
#else
  #undef PREP
  #define PREP(fncName) [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf), QFUNC(fncName)] call CBA_fnc_compileFunction
#endif

#define CHECK_FOLDER_1 icon_styles
#define CHECK_FOLDER_2 standard
#define CHECK_FOLDER_3 nato

#define SYSTEM_CHECK RUN_CHECK(CHECK_FOLDER_1,CHECK_FOLDER_2,CHECK_FOLDER_3)
#define RUN_CHECK(var1,var2,var3) !(call compileScript [QPATHTOF(BUILD_CHECK_FILE(var1,var2,var3))])
