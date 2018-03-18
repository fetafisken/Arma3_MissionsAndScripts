if(isServer) then 
{
	//init variables
	myConvoy=false;

	countdown = "Countdown" call BIS_fnc_getParamValue;
	if (countdown >= 0) then {
		countdown spawn 
		{
			waituntil {time > 0};
			
			waitUntil {_this - time < 120};
			hint "2 min left";

			waituntil {_this < time};
			deleteWaypoint [group (myVehicles select 0), 0]; //removes hold waypoint
		};
	};
};
