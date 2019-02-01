#include "../script_component.hpp"

// loop
[diwako_dui_fnc_cacheLoop,[],0.5] call CBA_fnc_waitAndExecute;

// if both compass and namelist are not enabled, just remove the controls if there are any
if !(diwako_dui_enable_compass || diwako_dui_namelist) exitWith {
    for "_i" from 0 to (count diwako_dui_namebox_lists) do {
        ctrlDelete ctrlParentControlsGroup (diwako_dui_namebox_lists deleteAt 0);
    };
    ("diwako_dui_namebox" call BIS_fnc_rscLayer) cutRsc ["diwako_dui_RscNameBox","PLAIN", 0, true];
};

private _player = [] call CBA_fnc_currentUnit;
_group = units group _player;
diwako_dui_group = _group;
private _uiScale = diwako_dui_hudScaling;
private _uiPixels = diwako_dui_uiPixels;

private _colorNameSpace = missionNamespace getVariable format["diwako_dui_colors_%1", diwako_dui_colors];
private _iconNamespace = missionNamespace getVariable format["diwako_dui_icon_%1", diwako_dui_icon_style];

{
    if (alive _x) then {
        _x setVariable ["diwako_dui_compass_icon", [_x, _iconNamespace, _player, true] call diwako_dui_fnc_getIcon];
        _x setVariable ["diwako_dui_icon", [_x, _iconNamespace] call diwako_dui_fnc_getIcon];
        // when remote controling a an AI assign can return nil
        private _assignedTeam = [assignedTeam _x] param [0, "MAIN"];

        private _color = _colorNameSpace getVariable [_assignedTeam, "#FFFFFF"];
        _x setVariable ["diwako_dui_color", _color];

        private _compassColor = _colorNameSpace getVariable [(format ["%1_compass", _assignedTeam]), [1,1,1]];
        _x setVariable ["diwako_dui_compass_color", _compassColor];
    };
} forEach _group;

// start compass if enabeld but not running yet
if (diwako_dui_enable_compass) then {
    private _compassDisplay = uiNamespace getVariable ["diwako_dui_RscCompass", displayNull];
    if (diwako_dui_compass_pfHandle <= -1 || {isNull _compassDisplay}) then {
        [diwako_dui_compass_pfHandle] call CBA_fnc_removePerFrameHandler;
        ("diwako_dui_compass" call BIS_fnc_rscLayer) cutRsc ["diwako_dui_RscCompass","PLAIN", 0, true];
        [] call diwako_dui_fnc_compass;
    };

    private _compassCtrl = _compassDisplay displayCtrl IDC_COMPASS;
    _compassCtrl ctrlSetText (diwako_dui_compass_style select ("ItemCompass" in assignedItems _player));

    if (diwako_dui_setCompass) then {
        diwako_dui_setCompass = false;
        private _ctrlHeight = pixelH * _uiPixels;
        private _ctrlWidth = pixelW * _uiPixels;
        private _ctrlMiddleX = 0.5 - (pixelW * (_uiPixels / 2));
        private _compassY = safeZoneY + safeZoneH - (pixelH * (_uiPixels + 10));

        private _dirCtrl = _compassDisplay displayCtrl IDC_DIRECTION;
        private _grpCtrl = _compassDisplay displayCtrl IDC_COMPASS_CTRLGRP;

        _compassCtrl ctrlSetPosition [
            profileNamespace getVariable ["diwako_dui_compass_x", _ctrlMiddleX],
            profileNamespace getVariable ["diwako_dui_compass_y", _compassY],
            _ctrlWidth,
            _ctrlHeight
        ];
        _compassCtrl ctrlSetTextColor [1 ,1 , 1, diwako_dui_compass_opacity];
        _compassCtrl ctrlCommit 0;
        _dirCtrl ctrlSetPosition [
            profileNamespace getVariable ["diwako_dui_compass_x", _ctrlMiddleX],
            (profileNamespace getVariable ["diwako_dui_compass_y", _compassY]) - (pixelH * 25 * _uiScale),
            // safeZoneY + safeZoneH - (pixelH * (_uiPixels + (55 * _uiScale))),
            _ctrlWidth,
            pixelH * 70 * _uiScale
        ];
        _dirCtrl ctrlSetTextColor [1, 1, 1, 1];
        _dirCtrl ctrlSetFont diwako_dui_font;
        _dirCtrl ctrlCommit 0;
        _grpCtrl ctrlSetPosition [
           profileNamespace getVariable ["diwako_dui_compass_x", _ctrlMiddleX],
           profileNamespace getVariable ["diwako_dui_compass_y", _compassY],
           _ctrlWidth,
           _ctrlHeight
        ];
        _grpCtrl ctrlCommit 0;

        diwako_dui_bearing_size_calc = diwako_dui_dir_size * diwako_dui_a3UiScale * diwako_dui_hudScaling * diwako_dui_windowHeightMod;
    };
};

// built name list from here
private _display = uiNamespace getVariable ["diwako_dui_RscNameBox", displayNull];
if (isNull _display) exitWith {
    if (diwako_dui_namelist) then {
        ("diwako_dui_namebox" call BIS_fnc_rscLayer) cutRsc ["diwako_dui_RscNameBox","PLAIN", 0, true];
        _display = uiNamespace getVariable ["diwako_dui_RscNameBox", displayNull];
    };
};

private _grpCtrl = _display displayCtrl IDC_NAMEBOX_CTRLGRP;
private _lists = diwako_dui_namebox_lists;

// delete all name list controls if not active
if !(diwako_dui_namelist) exitWith {
    if ((count _lists) > 0) then {
        for "_i" from (count _lists) -1 to 0 step -1 do {
            ctrlDelete ctrlParentControlsGroup (_lists deleteAt _i);
        };
        ("diwako_dui_namebox" call BIS_fnc_rscLayer) cutText ["","PLAIN"];
    };
};

if !([_player] call diwako_dui_fnc_canHudBeShown) exitWith {
    _grpCtrl ctrlShow false;
};

if (diwako_dui_setNamelist) then {
    diwako_dui_setNamelist = false;
    private _nameList = _display displayCtrl IDC_NAMEBOX;
    private _nameListPos = [
        profileNamespace getVariable ["diwako_dui_namelist_x", 0.5 + (pixelW * (_uiPixels / 2 + 10))],
        profileNamespace getVariable ["diwako_dui_namelist_y",safeZoneY + safeZoneH - (pixelH * (_uiPixels + 10))],
        (0.5 - (pixelW * (_uiPixels / 2 + 10))) + safeZoneW,
        pixelH * (_uiPixels + 10)
    ];
    _grpCtrl ctrlSetPosition _nameListPos;
    _grpCtrl ctrlCommit 0;
    _nameList ctrlSetPosition _nameListPos;
    _nameList ctrlCommit 0;
};


// no need to show any names if you are alone in the group
if (count _group == 1) exitWith {
    if ((count _lists) > 0) then {
        for "_i" from (count _lists) -1 to 0 step -1 do {
            ctrlDelete ctrlParentControlsGroup (_lists deleteAt _i);
        };
    };
};
if !(ctrlShown _grpCtrl) then {
    _grpCtrl ctrlShow true;
};
private _text = "";
private _curList = controlNull;
private _listIndex = 0;
private _selectedUnits = groupSelectedUnits _player;
private _a3UiScale = linearConversion [0.55,0.7,getResolution # 5,1,0.85,false];
private _textSize = diwako_dui_namelist_size * diwako_dui_a3UiScale * diwako_dui_windowHeightMod;
private _listWidth = diwako_dui_namelist_width * pixelW * diwako_dui_hudScaling;
private _listHeight = 128 * pixelH * diwako_dui_hudScaling;
private _ctrlPosList = [0, 0, _listWidth*10, _listHeight];
private _shadow = diwako_dui_namelist_text_shadow;
{
    if (_forEachIndex mod round(5/_textSize*_uiScale) == 0) then {
        if !(isNull _curList) then {
            _curList ctrlSetStructuredText parseText _text;
            _curList ctrlSetPosition _ctrlPosList;
            _curList ctrlCommit 0;
            _text = "";
        };
        if (count _lists >= (_listIndex + 1)) then {
            _curList = _lists # _listIndex;
        } else {
            ctrlPosition _grpCtrl params ["_left", "_top", "_width", "_height"];
            // create group
            private _curGrp = _display ctrlCreate["RscControlsGroupNoScrollbars", -1, _grpCtrl];
            private _ctrlPos = [
                (0 * pixelW) * _listIndex + _listWidth * _listIndex,
                0,
                _listWidth,
                _listHeight
            ];
            _curGrp ctrlSetPosition _ctrlPos;
            _curGrp ctrlCommit 0;

            _curList = _display ctrlCreate ["RscStructuredText", -1, _curGrp];
            _curList ctrlSetFont diwako_dui_font;
            _curList ctrlSetBackgroundColor [0,0,0,diwako_dui_namelist_bg];
            _lists pushBack _curList;
            _curList ctrlCommit 0;
        };
        _listIndex = _listIndex + 1;
    };
    private _unit = _x;
    private _selected = ["", ">>"] select (_selectedUnits findIf {_x == _unit} > -1);
    private _buddy = ["", _iconNamespace getVariable ["buddy", DUI_BUDDY]] select (_player == (_unit getVariable ["diwako_dui_buddy", objNull]));
    private _icon = [_unit getVariable ["diwako_dui_icon", DUI_RIFLEMAN], ""] select (_buddy != "" && {diwako_dui_namelist_only_buddy_icon});
    _text = format ["%1<t color='%4' size='%6' shadow='%8' shadowColor='#000000' valign='middle' align='left'>%5<img image='%7'valign='bottom'/><img image='%2'valign='bottom'/> %3</t><br/>",
        _text, // 1
        _icon, // 2
        _unit getVariable ["ACE_Name", name _unit], // 3
        _unit getVariable ["diwako_dui_color","#FFFFFF"], // 4
        _selected, // 5
        _textSize, // 6
        _buddy, // 7
        _shadow]; // 8
} forEach _group;

if !(isNull _curList) then {
    _curList ctrlSetStructuredText parseText _text;
    _curList ctrlSetPosition _ctrlPosList;
    _curList ctrlCommit 0;
};
for "_i" from (count _lists) -1 to _listIndex step -1 do {
    ctrlDelete ctrlParentControlsGroup (_lists deleteAt _i);
};
