params [["_player",[] call CBA_fnc_currentUnit]];
!(
	visibleMap || 
	{diwako_dui_toggled_off || 
	{!alive _player || 
	{!isNull curatorCamera || 
	// {!isNull (findDisplay 312) || 
	{(_player getVariable ["ace_spectator_isSet", false]) ||
	{dialog ||
	{missionNamespace getVariable ["ace_interact_menu_openedMenuType",-1] > -1 || 
	{!isNull(missionNamespace getVariable ["BIS_DEBUG_CAM", objNull]) ||
	{!isNull(missionNamespace getVariable ["BIS_fnc_camera_cam", objNull]) }}}}}}}}
)