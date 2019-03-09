#include "script_component.hpp"

addMissionEventHandler ["Draw3D", {
  if (GVAR(show)) then {
    call FUNC(display);
  };
}];
