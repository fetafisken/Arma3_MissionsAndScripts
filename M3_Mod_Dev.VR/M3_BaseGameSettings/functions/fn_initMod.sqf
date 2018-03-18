_mode = param [0,"",[""]];
_input = param [1,[],[[]]];

switch _mode do {
	// Default object init
	case "init": {
		_logic = _input param [0,objNull,[objNull]]; // Module logic
		_isActivated = _input param [1,true,[true]]; // True when the module was activated, false when it's deactivated
		_isCuratorPlaced = _input param [2,false,[true]]; // True if the module was placed by Zeus
		// ... code here...

	};
};


if (!isServer) exitWith {};


r = _input;
y = _mode;

missionNamespace setVariable ["rallypoint", false, true];

[west, 30] call BIS_fnc_respawnTickets;
[east, 30] call BIS_fnc_respawnTickets;
[resistance, 30] call BIS_fnc_respawnTickets;


0 = [] spawn M3_fnc_setupEvents;
