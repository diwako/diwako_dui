#include "script_component.hpp"

params ["_unit"];

_unit setVariable [QGVAR(name), name _unit];
_unit setVariable [QGVAR(groupName), groupID group _unit];

private _rank = rank _unit;
private _styledRank = GVAR(RankNames) getOrDefault [_rank, ""];
if (_styledRank isNotEqualTo "") then {
    _rank = _styledRank
};
_unit setVariable [QGVAR(rank), _rank];
