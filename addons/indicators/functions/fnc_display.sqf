#include "script_component.hpp"

private _player = [] call CBA_fnc_currentUnit;
if !([_player] call EFUNC(main,canHudBeShown)) exitWith {};

private _clamp = NIGHT_ALPHA + (sunOrMoon * DAY_ALPHA);

{
    private _icon_pos = ASLtoAGL(visiblePositionASL(vehicle(_x)));
    private _height_adjust = 0.2;
    if ((vehicle _x) isEqualTo _x) then {
        _height_adjust = _height_adjust + (_x selectionPosition "pelvis" select 2);
    } else {
        _height_adjust = _height_adjust + 0.7;
    };
    _icon_pos set [2, (_icon_pos select 2) + _height_adjust];

    private _distance = _icon_pos distance (vehicle _player);

    private _icon = "\A3\ui_f\data\igui\cfg\cursors\select_ca.paa";
    if (_x isEqualTo (leader group _player)) then {
        _icon = "\A3\ui_f\data\igui\cfg\cursors\leader_ca.paa";
    };
    _icon = _player getVariable [QGVAR(icon), _icon];

    private _color = [0.85, 0.4, 0];
    if (_distance > diwako_dui_distanceWarning || {!(isNull objectParent _x) || {_x == _player}}) then {
        _color = + (_x getVariable [QEGVAR(radar,compass_color), [1,1,1]]);
    };
    private _alpha = _x getVariable [QEGVAR(radar,occlusion_alpha), 1];
    _alpha = _alpha * (linearConversion [10, GVAR(range), _distance, _clamp, 0, true]);
    _color pushBack _alpha;
    if (_alpha > 0) then {
        drawIcon3D [_icon, _color, _icon_pos, 1, 1, 0];
    };
} forEach ((units (group _player)) - [_player]);
