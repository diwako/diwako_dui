#include "script_component.hpp"

params ["_target", "_player"];
private _vehicle = vehicle _target;
private _distance = _player distance _vehicle;
private _pos = _vehicle modelToWorld [0,0,1.4];

private _darknessPenalty = 0;
private _rangeModifier = 0;

private _light = sunOrMoon;
/* Arma 3 2.00 getLightingAt Code Implementation
private _lightingValue = getLightingAt _target;

_lightingValue params ["", "_ambient", "", "_dynamic"];
private _light = ((((_lightingValue select 1) + (_lightingValue select 3)) max 0) min 1);
*/

switch (currentVisionMode _player) do {
    case (0): {
        _darknessPenalty = linearConversion [0, 1, _light, 0.25, 0.0, true];
        _rangeModifier = linearConversion [0, 1, _light, 0.50, 1.0, true];
    };
    default {
        _rangeModifier = linearConversion [0, 1, _light, 0.75, 1.0, true];
    };
};

private _maxDistance = GVAR(renderDistance);

if !(alive _target) then {
    _maxDistance = GVAR(deadRenderDistance);
};

if (GVAR(enableFOVBoost)) then {
    _maxDistance = _maxDistance * ((call CBA_fnc_getFov) select 1);
};

private _fadeValue = (linearConversion [0, (_maxDistance * _rangeModifier), _distance, 1, 0, true]) - _darknessPenalty;
if (GVAR(enableOcclusion)) then {
    _fadeValue = _fadeValue - ([objNull, "FIRE"] checkVisibility [eyePos _player, _pos]);
};

// this function allows Mission Builders to implement there own coefs
private _coefModifier = missionNamespace getVariable QFUNC(nametagsCustomFadeCalculation);
if !(isNil "_coefModifier") then {
    _fadeValue = [_fadeValue, _target, _player] call _coefModifier;
};

1 - _fadeValue
