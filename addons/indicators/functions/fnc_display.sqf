#include "script_component.hpp"

private _player = [] call CBA_fnc_currentUnit;
if !([_player] call EFUNC(main,canHudBeShown)) exitWith {};

private _clamp = call EFUNC(main,ambientBrightness);

private _icon_pos = [];
private _height_adjust = 0.2;
private _distance = 0;
private _color = [0.85, 0.4, 0];
private _alpha = 0;
private _secondIcon = "";
private _plrVeh = (vehicle _player);
private _disanceWarning = diwako_dui_distanceWarning;
private _range = GVAR(range);
private _vehCurUnit = objNull;
private _size = GVAR(size);
private _useACE = GVAR(useACENametagsRange);

{
    _alpha = _x getVariable [QEGVAR(radar,occlusion_alpha), 1];
    if (_alpha > 0) then {
        _vehCurUnit = vehicle _x;
        _icon_pos = ASLtoAGL(visiblePositionASL _vehCurUnit);
        if (_vehCurUnit isEqualTo _x) then {
            _icon_pos = _icon_pos vectorAdd [0, 0, (0.2 + (_x selectionPosition "pelvis" select 2))];
        } else {
            _icon_pos = _icon_pos vectorAdd [0, 0, 0.9];
        };

        _distance = _icon_pos distance _plrVeh;

        if (_distance <= _range) then {
            _color = [0.85, 0.4, 0];
            if (_distance > _disanceWarning || {!(isNull objectParent _x)}) then {
                _color = + (_x getVariable [QEGVAR(radar,compass_color), [1,1,1]]);
            };
            if (_useACE) then {
                _alpha = (_x getVariable "ace_nametags_drawParameters") select 1 select 1 select 3;
            } else {
                _alpha = _alpha * (linearConversion [10, _range, _distance, _clamp, 0, true]);
            };
            _color pushBack _alpha;
            if (_alpha > 0) then {
                drawIcon3D [_x getVariable[QGVAR(outerIcon), ""], _color, _icon_pos, _size, _size, 0];
                _secondIcon = _x getVariable[QGVAR(innerIcon), ""];
                if (_secondIcon != "" && {_vehCurUnit isEqualTo _x}) then {
                    drawIcon3D [_secondIcon, _color, _icon_pos, _size, _size, 0];
                };
            };
        };
    };
} forEach ((units (group _player)) - [_player]);
