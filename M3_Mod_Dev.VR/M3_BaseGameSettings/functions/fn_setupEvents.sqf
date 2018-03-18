if (player != player) then {
    waitUntil {player == player};
    waitUntil {time > 10};
};

_index = player addMPEventHandler ["MPRespawn", M3_fnc_handleRespawn];
