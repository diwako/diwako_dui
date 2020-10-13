#include "script_component.hpp"

params ["_unit"];

_unit setVariable [QGVAR(name), name _unit];
_unit setVariable [QGVAR(groupName), groupID group _unit];

private _rank = rank _unit;
private _index = (GVAR(RankNames) select 0) find _rank;
if (_index isNotEqualTo -1) then {
    _rank = (GVAR(RankNames) select 1) select _index;
};
_unit setVariable [QGVAR(rank), _rank];
