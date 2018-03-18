class CfgRespawnTemplates
{
	// Class used in respawnTemplates entry
	class M3_respawn
	{
        onPlayerKilled = "\M3\scripts\killed.sqf";
        onPlayerRespawn = "\M3\scripts\respawn.sqf";

        respawn = 3;
		respawnDelay = 1;
		respawnOnStart = 0;
        respawnButton = 1;
	};
	class Spectator
	{
		onPlayerRespawn = "BIS_fnc_respawnSpectator";
	};
};
