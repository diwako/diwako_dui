#include "..\script_component.hpp"

([QGVAR(Compass)] call BIS_fnc_rscLayer) cutFadeOut 0;
GVAR(CompassShown) = false;
