params ["_unit1", "_unit2", ["_assign", true]];

if !(isNull (_unit1 getVariable ["diwako_dui_buddy", objNull])) then {
    (_unit1 getVariable ["diwako_dui_buddy", objNull]) setVariable ["diwako_dui_buddy", nil, true];
};
if !(isNull (_unit2 getVariable ["diwako_dui_buddy", objNull])) then {
    (_unit2 getVariable ["diwako_dui_buddy", objNull]) setVariable ["diwako_dui_buddy", nil, true];
};

if (_assign) then {
    _unit1 setVariable ["diwako_dui_buddy", _unit2, true];
    _unit2 setVariable ["diwako_dui_buddy", _unit1, true];
} else {
    _unit1 setVariable ["diwako_dui_buddy", nil, true];
    _unit2 setVariable ["diwako_dui_buddy", nil, true];
};
