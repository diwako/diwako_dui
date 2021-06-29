#ifndef MAINPREFIX
    #include "script_component.hpp"
#endif
private _cat = format ["%1 - %2",localize "STR_dui_mod", localize "STR_dui_addon_nametags"];

private _curCat = localize "STR_dui_cat_general";

[
    QGVAR(enabled),
    "CHECKBOX",
    ["STR_dui_nametags_enabled", ""],
    [_cat, _curCat],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(enableOcclusion),
    "CHECKBOX",
    ["STR_dui_nametags_enableOcclusion", "STR_dui_nametags_enableOcclusion_desc"],
    [_cat, _curCat],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(useLIS),
    "CHECKBOX",
    ["STR_dui_nametags_useLIS", "STR_dui_nametags_useLIS_desc"],
    [_cat, _curCat],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(fadeInTime),
    "SLIDER",
    ["STR_dui_nametags_fadeInTime", "STR_dui_nametags_fadeInTime_desc"],
    [_cat, _curCat],
    [0, 1, 0.05, 2],
    false
] call CBA_fnc_addSetting;

[
    QGVAR(fadeOutTime),
    "SLIDER",
    ["STR_dui_nametags_fadeOutTime", "STR_dui_nametags_fadeOutTime_desc"],
    [_cat, _curCat],
    [0, 1, 0.5, 2],
    false
] call CBA_fnc_addSetting;

[
    QGVAR(renderDistance),
    "SLIDER",
    ["STR_dui_nametags_renderDistance", "STR_dui_nametags_renderDistance_desc"],
    [_cat, _curCat],
    [0, 100, 40, 1],
    false
] call CBA_fnc_addSetting;

[
    QGVAR(deadRenderDistance),
    "SLIDER",
    ["STR_dui_nametags_deadRenderDistance", "STR_dui_nametags_deadRenderDistance_desc"],
    [_cat, _curCat],
    [0, 10, 3.5, 1],
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enableFOVBoost),
    "CHECKBOX",
    ["STR_dui_nametags_enableFOVBoost", "STR_dui_nametags_enableFOVBoost_desc"],
    [_cat, _curCat],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(drawRank),
    "CHECKBOX",
    ["STR_dui_nametags_drawRank", ""],
    [_cat, _curCat],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(showUnconAsDead),
    "CHECKBOX",
    ["STR_dui_nametags_showUnconAsDead", ""],
    [_cat, _curCat],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(useSideIsFriendly),
    "CHECKBOX",
    ["STR_dui_nametags_useSideIsFriendly", "STR_dui_nametags_useSideIsFriendly_desc"],
    [_cat, _curCat],
    true
] call CBA_fnc_addSetting;

private _curCat = "STR_dui_cat_fonts";

[
    QGVAR(fontName),
    "LIST",
    ["STR_dui_nametags_nameFont", "STR_dui_nametags_nameFont_desc"],
    [_cat, _curCat],
    [EGVAR(main,availableFonts), EGVAR(main,availableFonts), 5],
    false
] call CBA_fnc_addSetting;

[
    QGVAR(fontGroup),
    "LIST",
    ["STR_dui_nametags_groupNameFont", "STR_dui_nametags_groupNameFont_desc"],
    [_cat, _curCat],
    [EGVAR(main,availableFonts), EGVAR(main,availableFonts), 6],
    false
] call CBA_fnc_addSetting;

[
    QGVAR(nameFontShadow),
    "LIST",
    ["STR_dui_nametags_nameShadow", ""],
    [_cat, _curCat],
    [[0, 1, 2], [
        localize "STR_dui_namelist_text_shadow_0",
        localize "STR_dui_namelist_text_shadow_1",
        localize "STR_dui_namelist_text_shadow_2"
    ], 1],
    false
] call CBA_fnc_addSetting;

private _rankNames = keys GVAR(RankNames);
private _defaultIndex = "default" find _rankNames;
[
    QGVAR(rankNameStyle),
    "LIST",
    ["STR_dui_nametags_rankNameStyle", "STR_dui_nametags_rankNameStyle_desc"],
    [_cat, _curCat],
    [_rankNames, _rankNames, _defaultIndex],
    false
] call CBA_fnc_addSetting;

[
    QGVAR(customRankStyle),
    "EDITBOX",
    ["STR_dui_nametags_customRankStyle", "STR_dui_nametags_customRankStyle_desc"],
    [_cat, _curCat],
    str [["PRIVATE","CORPORAL","SERGEANT","LIEUTENANT","CAPTAIN","MAJOR","COLONEL"], ["Pvt", "Cpl", "Sgt", "Lt", "Capt", "Maj", "Col"]],
    false,
    {
        params ["_value"];
        private _parsedArray = parseSimpleArray _value;
        if (count _parsedArray == 2) exitWith {
            GVAR(RankNames) set ["custom", (_parsedArray select 0) createHashMapFromArray (_parsedArray select 0)];
        };
        if (count _parsedArray == 7) exitWith {
            GVAR(RankNames) set ["custom", createHashMapFromArray _parsedArray];
        };
        // Q(diwako): Should we display some kind of Hint it is not a valid hashMap array?
    }
] call CBA_fnc_addSetting;

[
    QGVAR(groupFontShadow),
    "LIST",
    ["STR_dui_nametags_groupShadow", ""],
    [_cat, _curCat],
    [[0, 1, 2], [
        localize "STR_dui_namelist_text_shadow_0",
        localize "STR_dui_namelist_text_shadow_1",
        localize "STR_dui_namelist_text_shadow_2"
    ], 1],
    false
] call CBA_fnc_addSetting;

[
    QGVAR(fontNameSize),
    "SLIDER",
    ["STR_dui_nametags_fontNameSize", "STR_dui_nametags_fontNameSize_desc"],
    [_cat, _curCat],
    [0, 20, 10, 1],
    false
] call CBA_fnc_addSetting;

[
    QGVAR(fontGroupNameSize),
    "SLIDER",
    ["STR_dui_nametags_fontGroupNameSize", "STR_dui_nametags_fontGroupNameSize_desc"],
    [_cat, _curCat],
    [0, 20, 8, 1],
    false
] call CBA_fnc_addSetting;

private _curCat = "STR_dui_cat_custom_color";

[
    QGVAR(deadColor),
    "COLOR",
    ["STR_dui_nametags_deadColor", "STR_dui_nametags_deadColor_desc"],
    [_cat, _curCat],
    [0.2, 0.2, 0.2, 1],
    false,
    {
        EGVAR(main,colors_custom) setVariable ["dead_compass", _this select [0, 3]];
        EGVAR(main,colors_custom) setVariable ["dead", [(_this select 0) * 255,(_this select 1) * 255,(_this select 2) * 255] call EFUNC(main,toHex)];
    }
] call CBA_fnc_addSetting;

[
    QGVAR(groupColor),
    "COLOR",
    ["STR_dui_nametags_groupColor", "STR_dui_nametags_groupColor_desc"],
    [_cat, _curCat],
    [1, 1, 1, 1],
    false,
    {
        EGVAR(main,colors_custom) setVariable ["group_compass", _this select [0, 3]];
        EGVAR(main,colors_custom) setVariable ["group", [(_this select 0) * 255,(_this select 1) * 255,(_this select 2) * 255] call EFUNC(main,toHex)];
    }
] call CBA_fnc_addSetting;

[
    QGVAR(nameOtherGroupColor),
    "COLOR",
    ["STR_dui_nametags_groupNameOtherColor", "STR_dui_nametags_groupNameOtherColor_desc"],
    [_cat, _curCat],
    [0.2, 1, 0, 1],
    false,
    {
        EGVAR(main,colors_custom) setVariable ["otherGroup_compass", _this select [0, 3]];
        EGVAR(main,colors_custom) setVariable ["otherGroup", [(_this select 0) * 255,(_this select 1) * 255,(_this select 2) * 255] call EFUNC(main,toHex)];
    }
] call CBA_fnc_addSetting;
[
    QGVAR(groupNameOtherGroupColor),
    "COLOR",
    ["STR_dui_nametags_nameOtherColor", "STR_dui_nametags_nameOtherColor_desc"],
    [_cat, _curCat],
    [0.6, 0.85, 0.6, 1],
    false,
    {
        EGVAR(main,colors_custom) setVariable ["otherName_compass", _this select [0, 3]];
        EGVAR(main,colors_custom) setVariable ["otherName", [(_this select 0) * 255,(_this select 1) * 255,(_this select 2) * 255] call EFUNC(main,toHex)];
    }
] call CBA_fnc_addSetting;
