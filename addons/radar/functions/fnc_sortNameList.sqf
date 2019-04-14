#include "script_component.hpp"

params ["_grp", "_player"];

private _newGrp = + _grp;
private _sqlFirst = GVAR(sqlFirst);
private _sql = objNull;
if (_sqlFirst) then {
	_sql = leader _player;
	_newGrp = _newGrp - [_sql];
};

private _nameSpace = GVAR(sortNamespace);

switch (GVAR(sortType)) do {
	case "name": {
		_newGrp = _newGrp apply { [_x getVariable ["ACE_Name", name _x], _x] };
		_newGrp sort true;
		_newGrp = _newGrp apply { _x select 1 };
	};
	case "fireteam": {
		_newGrp = _newGrp apply { [_nameSpace getVariable [[assignedTeam _x] param [0, "MAIN"], 9999], _x getVariable ["ACE_Name", name _x], _x] };
		_newGrp sort true;
		_newGrp = _newGrp apply { _x select 2 };
	};
	case "fireteam2": {
		_newGrp = _newGrp apply { [_nameSpace getVariable [[assignedTeam _x] param [0, "MAIN"], 9999], _nameSpace getVariable [rank _x, 9999], _x getVariable ["ACE_Name", name _x], _x] };
		_newGrp sort true;
		_newGrp = _newGrp apply { _x select 3 };
	};
	case "rank": {
		_newGrp = _newGrp apply { [_nameSpace getVariable [rank _x, 9999], _x getVariable ["ACE_Name", name _x], _x] };
		_newGrp sort true;
		_newGrp = _newGrp apply { _x select 2 };
	};
	default { };
};

if (_sqlFirst) then {
	_newGrp = [_sql] + _newGrp;
};

_newGrp
