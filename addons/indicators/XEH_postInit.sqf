#include "script_component.hpp"

[] call FUNC(cacheLoop);

addMissionEventHandler ["Draw3D", {
  if (GVAR(show)) then {
    call FUNC(display);
  };
}];
