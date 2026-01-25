#define MAINPREFIX z
#define PREFIX diwako_dui

#include "script_version.hpp"

#define VERSION         MAJOR.MINOR
#define VERSION_STR     MAJOR.MINOR.PATCHLVL.BUILD
#define VERSION_AR      MAJOR,MINOR,PATCHLVL,BUILD
#define VERSION_PLUGIN  MAJOR.MINOR.PATCHLVL.BUILD

#define REQUIRED_VERSION 2.20

#ifdef COMPONENT_BEAUTIFIED
    #define COMPONENT_NAME QUOTE(DUI - COMPONENT_BEAUTIFIED)
#else
    #define COMPONENT_NAME QUOTE(DUI - COMPONENT)
#endif

#define ADDON_MAIN diwako_dui_main
#define BUILD_CHECK_FILE(var1,var2,var3) ui\##var1##\##var2##\icon.bin
