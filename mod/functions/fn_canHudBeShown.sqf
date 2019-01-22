params [["_player",[] call CBA_fnc_currentUnit]];
!(
	visibleMap || 
	{diwako_dui_toggled_off || 
	{!alive _player || 
	{(_player getVariable ["ace_spectator_isSet", false]) ||
	{dialog ||
	{missionNamespace getVariable ["ace_interact_menu_openedMenuType",-1] > -1 || 
	{!isnull (missionNamespace getVariable ["ace_arsenal_camera", objNull]) || 
	{diwako_dui_inFeatureCamera}}}}}}}
)
