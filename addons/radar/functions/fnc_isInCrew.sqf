#include "script_component.hpp"
if (is3DEN || !hasInterface) exitWith { false };

params [["_player", objNull]];
private _vehicle = vehicle _player;

(_vehicle != _player) && { fullCrew [_vehicle, "cargo"] findIf {_player == _x # 0} == -1 }
