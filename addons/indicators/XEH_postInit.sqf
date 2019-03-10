#include "script_component.hpp"
if (is3DEN || !hasInterface) exitWith {};

[] call FUNC(cacheLoop);

addMissionEventHandler ["Draw3D", {
  if (GVAR(show)) then {
    call FUNC(display);
  };
}];
