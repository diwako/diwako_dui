#include "script_component.hpp"

private _player = call CBA_fnc_currentUnit;
if !([_player] call EFUNC(main,canHudBeShown)) exitWith {};

// Constants
private _clamp = NIGHT_ALPHA + (sunOrMoon * DAY_ALPHA);
private _vehPlayer = vehicle _player;
private _distanceWarning = diwako_dui_distanceWarning;
private _range = [GVAR(range), GVAR(range_crew)] select (GVAR(crew_range_enabled) && { _player call EFUNC(main,isInCrew) });
private _size = GVAR(size);
private _useACE = GVAR(useACENametagsRange);
private _camPosASL = AGLtoASL positionCameraToWorld [0, 0, 0];
private _scaleWithRange = GVAR(range_scale);
if (GVAR(fov_scale)) then {
    _size =  _size * ((call CBA_fnc_getFov) select 1);
};

// Variables that change for each unit
private _iconPos = [];
private _distance = 0;
private _color = [];
private _alpha = 0;
private _secondIcon = "";
private _vehTarget = objNull;
private _hasLineOfSight = false;
private _sizeFinal = 0;

{
    _alpha = _x getVariable [QEGVAR(radar,occlusion_alpha), 1];
    if (_alpha > 0) then {
        _vehTarget = vehicle _x;
        _iconPos = (ASLtoAGL visiblePositionASL _vehTarget) vectorAdd (if (_vehTarget isEqualTo _x) then {
            [0, 0, 0.2 + ((_x selectionPosition "pelvis") select 2)]
        } else {
            [0, 0, 0.9]
        });
        _distance = _iconPos distance _vehPlayer;

        if (_distance <= _range) then {
            if (_useACE) then {
                // Using cachedCall with the same frequency as nametags keeps them better synchronized
                _hasLineOfSight = [
                    [_camPosASL, eyePos _x, _player, _x],
                    {!(lineIntersects _this)},
                    _x, QGVAR(drawParameters), 0.1
                ] call ace_common_fnc_cachedCall;

                // ACE Nametags are only shown if player has lines of sight to target
                _alpha = if (_hasLineOfSight) then {
                    // ace_nametags_drawParameters is the parameters of a ACE cachedCall
                    // We do select 1 to get it's parameters, which are the parameters for a `drawIcon3D` call
                    // We then do select 1 to get the color for that call, select 3 is to get the alpha of that color
                    ((_x getVariable "ace_nametags_drawParameters") select 1 select 1 select 3)
                    min
                    (_alpha * (linearConversion [10, _range, _distance, call ace_common_fnc_ambientBrightness, 0, true]))
                } else {
                    0
                };
            } else {
                _alpha = _alpha * (linearConversion [10, _range, _distance, _clamp, 0, true]);
            };

            if (_alpha > 0) then {
                _color = +(if (_distance > _distanceWarning || {!(isNull objectParent _x)}) then {
                    _x getVariable [QEGVAR(main,compass_color), [1, 1, 1]]
                } else {
                    [0.85, 0.4, 0]
                });
                _color pushBack _alpha;

                _sizeFinal = _size;
                if (_scaleWithRange) then {
                    _sizeFinal = linearConversion [0, _range, _distance, _size, _size/10, true];
                };

                drawIcon3D [_x getVariable [QGVAR(outerIcon), ""], _color, _iconPos, _sizeFinal, _sizeFinal, 0];
                _secondIcon = _x getVariable [QGVAR(innerIcon), ""];
                if (_secondIcon isNotEqualTo "" && {_vehTarget isEqualTo _x}) then {
                    drawIcon3D [_secondIcon, _color, _iconPos, _sizeFinal, _sizeFinal, 0];
                };
            };
        };
    };
} forEach ((units _player) - [_player]);
