if (!isServer) exitWith {};

missionNamespace setVariable ["rallypoint", false, true];

[west, 30] call BIS_fnc_respawnTickets;
[east, 30] call BIS_fnc_respawnTickets;
[independent, 30] call BIS_fnc_respawnTickets;
