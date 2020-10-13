#include "script_component.hpp"
if (is3DEN || !hasInterface) exitWith { false };

params [["_player", objNull]];
private _vehicle = vehicle _player;

(_vehicle isNotEqualTo _player) && { fullCrew [_vehicle, "cargo"] findIf {_player isEqualTo (_x select 0)} isEqualTo -1 }
