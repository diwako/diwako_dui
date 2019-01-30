params ["_player"];
!(
	visibleMap || 
	{diwako_dui_toggled_off || 
	{!alive _player || 
	{(_player getVariable ["ace_spectator_isSet", false]) ||
	{dialog ||
	{diwako_dui_ace_hide_interaction && {missionNamespace getVariable ["ace_interact_menu_openedMenuType",-1] > -1} || 
	{!isnull (missionNamespace getVariable ["ace_arsenal_camera", objNull]) || 
	{diwako_dui_inFeatureCamera}}}}}}}
)
