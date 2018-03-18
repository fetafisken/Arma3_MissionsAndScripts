//Set "lead" as variable name for the player unit.
//Add "rallypoint = false;" in the init field for that unit
//Add The module Respawn tickets and set the amount
//Add this to the description.ext file
/*
class Params
{
	class TPR
	{
		title = "Tickets Per Rally";
		values[] = {3, 5, 7, 9, 10, 20};
		default = 9;
	};
	class RPO
	{
		title = "Rallypoint Object";
		values[] = {0, 1, 2, 3};
		texts[] = {"Tent", "Dome Tent", "Sleeping bag", "Toilet"};
		default = 1;
	};
	class RPC
	{
		title = "Rallypoint Cooldown";
		values[] = {10, 60, 120, 300, 600, 1200};
		texts[] = {"10 sec (DEV)", "60 sec", "2 min", "5 min", "10 min", "20 min"};
		default = 300;
	};
};
*/




missionNamespace setVariable ["rallypoint", true, true];
//publicVariable "rallypoint";

_TPR = 4; //"TPR" call BIS_fnc_getParamValue;
_RPO = 0; //"RPO" call BIS_fnc_getParamValue;
_RPC = 10; //"RPC" call BIS_fnc_getParamValue;

switch (_RPO) do {
    case 1: { _RPO = "Land_TentDome_F" };
    case 2: { _RPO = "Land_Sleeping_bag_brown_F" };
    case 3: { _RPO = "Land_ToiletBox_F" };
    default { _RPO = "Land_TentA_F" };
};


_target = _this select 0;
_caller = _this select 1; // same as _target
_ID = _this select 2;

if (isNull player && isplayer _caller) exitWith {};

hint format ["Hello %1",_TPR ];
_caller removeAction _ID;

_player = _caller;
_side =  side _player;

//_tickets = missionTickets;
_tickets = [_side] call BIS_fnc_respawnTickets;

if(_tickets > _TPR) then { _tickets = _tickets - _TPR; }
else { _tickets = 1; };


_spawnPos = position _player;
_tent = _RPO createVehicle position _player;
_tent setPos (getPos _player vectorAdd (vectorDir _player vectorMultiply 2));
_tent setVectorDir vectorDir _player;


_rally = [_side, _spawnPos,"Rallypoint"] call BIS_fnc_addRespawnPosition;

waitUntil{missionNamespace getVariable "rallypoint"};
sleep 1;
missionNamespace setVariable ["rallypoint", false, true];
//publicVariable "rallypoint";



[_RPC, _caller] spawn {
	_RPC = _this select 0;
	_caller = _this select 1;

	sleep _RPC; // timeout/cooldown for rallypoint in sec
    0 = _caller addAction ["<t color='#FF0000'>Rallypoint</t>", M3_fnc_deployRally];
};

//waitUntil{ rallypoint OR (_tickets > missionTickets) };
waitUntil{missionNamespace getVariable "rallypoint" OR (_tickets > [_side] call BIS_fnc_respawnTickets) };

deleteVehicle _tent;
_rally call BIS_fnc_removeRespawnPosition;
