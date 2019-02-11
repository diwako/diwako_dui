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
if (diwako_dui_compass_hide_blip_alone_group && {(count _group) <= 1}) then {
    _group = [];
};
diwako_dui_group = + _group;

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

private _specialTrack = missionNamespace getVariable ["diwako_dui_special_track", []];
if (_specialTrack isEqualType [] && {!(_specialTrack isEqualTo [])}) then {
    private _toTrack = [];
    private _vehNamespace = diwako_dui_vehicleNamespace;
    {
        if !(isNull _x) then {
            _x setVariable ["diwako_dui_compass_color", (_colorNameSpace getVariable ["tracked_compass", [1,1,1]])];
            if (_x isKindOf "CAManBase") then {
                _x setVariable ["diwako_dui_compass_icon", [_x, _iconNamespace, _player, true] call diwako_dui_fnc_getIcon];
            };
            if (_x isKindOf "LandVehicle" || _x isKindOf "Air") then {
                private _type = (typeOf _x);
                private _picture = _vehNamespace getVariable _type;
                if (isNil "_picture") then {
                    _picture = getText (configfile >> "CfgVehicles" >> _type >> "icon");
                    _vehNamespace setVariable [_type, _picture];
                };
                _x setVariable ["diwako_dui_compass_icon", _picture];
                _x setVariable ["diwako_dui_icon_size", 2];
            };
            _toTrack pushBackUnique _x;
        };
    } forEach _specialTrack;
    diwako_dui_group = _toTrack + diwako_dui_group - [objNull];
};

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

        if (diwako_dui_use_layout_editor) then {
            _ctrlMiddleX = profileNamespace getVariable ["igui_diwako_dui_compass_x", _ctrlMiddleX];
            _compassY = profileNamespace getVariable ["igui_diwako_dui_compass_y", _compassY];
        };

        diwako_dui_bearing_size_calc = diwako_dui_dir_size * diwako_dui_a3UiScale * diwako_dui_hudScaling * diwako_dui_windowHeightMod;

        _compassCtrl ctrlSetPosition [
            _ctrlMiddleX,
            _compassY,
            _ctrlWidth,
            _ctrlHeight
        ];
        _compassCtrl ctrlSetTextColor [1 ,1 , 1, diwako_dui_compass_opacity];
        _compassCtrl ctrlCommit 0;
        _grpCtrl ctrlSetPosition [
           _ctrlMiddleX,
           _compassY,
           _ctrlWidth,
           _ctrlHeight
        ];
        _grpCtrl ctrlCommit 0;
        _dirCtrl ctrlSetPosition [
            _ctrlMiddleX,
            _compassY - (pixelH * 25 * _uiScale),
            // safeZoneY + safeZoneH - (pixelH * (_uiPixels + (55 * _uiScale))),
            _ctrlWidth,
            pixelH * 70 * _uiScale
        ];
        _dirCtrl ctrlSetTextColor [1, 1, 1, 1];
        _dirCtrl ctrlSetFont diwako_dui_font;
        _dirCtrl ctrlCommit 0;
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
    private _xPos = 0.5 + (pixelW * (_uiPixels / 2 + 10));
    private _yPos = safeZoneY + safeZoneH - (pixelH * (_uiPixels + 10));
    if (diwako_dui_use_layout_editor) then {
        _xPos = profileNamespace getVariable ["igui_diwako_dui_namelist_x", _xPos];
        _yPos = profileNamespace getVariable ["igui_diwako_dui_namelist_y", _yPos];
    };
    private _nameList = _display displayCtrl IDC_NAMEBOX;
    private _nameListPos = [
        _xPos,
        _yPos,
        0.5 * safeZoneW - (pixelW * (_uiPixels / 2 + 10)),
        pixelH * (_uiPixels + 10)
    ];
    _grpCtrl ctrlSetPosition _nameListPos;
    _grpCtrl ctrlCommit 0;
    _nameList ctrlSetPosition _nameListPos;
    _nameList ctrlCommit 0;
};


// no need to show any names if you are alone in the group
if (count _group <= 1) exitWith {
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
private _textSize = diwako_dui_namelist_size * diwako_dui_a3UiScale;
private _listWidth = diwako_dui_namelist_width * pixelW * diwako_dui_hudScaling;
private _listHeight = 128 * pixelH * diwako_dui_hudScaling;
private _ctrlPosList = [0, 0, _listWidth*10, _listHeight];
private _shadow = diwako_dui_namelist_text_shadow;
private _bgOpacity = diwako_dui_namelist_bg;
private _onlyBuddyIcon = diwako_dui_namelist_only_buddy_icon;
private _heightMod = diwako_dui_windowHeightMod;
{
    if (_forEachIndex mod floor(5/(_textSize*_uiScale)) == 0) then {
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
            _curList ctrlSetBackgroundColor [0,0,0,_bgOpacity];
            _lists pushBack _curList;
            _curList ctrlCommit 0;
        };
        _listIndex = _listIndex + 1;
    };
    private _unit = _x;
    private _selected = "";
    if ((count _selectedUnits) > 0 && {_unit != _player}) then {
        private _curName = vehicleVarName _unit;
        _unit setVehicleVarName "";
        private _defaultIdent = str _unit;
        _unit setVehicleVarName _curName;
        private _arr = [_defaultIdent, ":"] call CBA_fnc_split;
        private _num = if ((count _arr) > 1) then {
            (_arr select 1) select [0, 2]
        } else {
            ""
        };
        _selected = format ["%1%2", (["", ">> "] select (_selectedUnits findIf {_x == _unit} > -1)), _num];
    };
    private _buddy = ["", _iconNamespace getVariable ["buddy", DUI_BUDDY]] select (_player == (_unit getVariable ["diwako_dui_buddy", objNull]));
    private _icon = [_unit getVariable ["diwako_dui_icon", DUI_RIFLEMAN], ""] select (_buddy != "" && {_onlyBuddyIcon});
    _text = format ["%1<t color='%4' size='%6' shadow='%8' shadowColor='#000000' valign='middle' align='left'>%5<img image='%7'valign='bottom'/><img image='%2'valign='bottom'/> %3</t><br/>",
        _text, // 1
        _icon, // 2
        _unit getVariable ["ACE_Name", name _unit], // 3
        _unit getVariable ["diwako_dui_color","#FFFFFF"], // 4
        _selected, // 5
        (_textSize * _heightMod), // 6
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
