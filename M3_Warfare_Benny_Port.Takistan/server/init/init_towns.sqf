/*
Divides the towns between both side or randomizes it.
*/
Private ['_wStart', '_eStart','_townStartMode', '_half'];
Private ['_nearTownsW', '_nearTownsE', '_near', '_z', '_camps'];
Private ['_total', '_limit'];

//waitUntil {initTown};
_wStart = position westStart;
_eStart = position eastStart;

_nearTownsW = [];
_nearTownsE = [];

//--- How to divide the towns.
_townStartMode = "townsStartMode" call BIS_fnc_getParamValue;
switch (_townStartMode) do {
    //--- Split half (50-50).
    case 1: {
        _half = round (count activeTowns) / 2;

        _near = [activeTowns,[],{_wStart distance _x},"ASCEND"] call BIS_fnc_sortBy;
        if (count _near > 0) then {
            //--- Would probably be bettor to limit half of _near array and
            //---   append the entire array directly
            for "_z" from 0 to _half do {
                _nearTownsW append [_near select _z];
            };
        };
        _nearTownsE = (activeTowns - _nearTownsW);



        //-- assign activeTown to side by variable.
        {
			_x setVariable ['sideID', west, true];
			_camps = synchronizedObjects _x;
			{_x setVariable ['sideID', west, true]} forEach _camps;
		} forEach _nearTownsW;

        {
			_x setVariable ['sideID', east, true];
			_camps = synchronizedObjects _x;
			{_x setVariable ['sideID', east, true]} forEach _camps;
		} forEach _nearTownsE;
    };

    //--- Nearby towns
    case 2: {
        _total = count activeTowns;
        _limit = floor(_total / 6);

        _near = [activeTowns,[],{_wStart distance _x},"ASCEND"] call BIS_fnc_sortBy;
        if (count _near > 0) then {
            for "_z" from 0 to _limit do {
                _nearTownsW append [_near select _z];
            };
        };

        _near = [(activeTowns - _nearTownsW),[],{_eStart distance _x},"ASCEND"] call BIS_fnc_sortBy;
        if (count _near > 0) then {
            for "_z" from 0 to _limit do {
                _nearTownsE append [_near select _z];
            };
        };


        //--- Benny removes pre placeed independent defences?
        {
            _x setVariable ['sideID', west, true];
            _camps = synchronizedObjects _x;
            {_x setVariable ['sideID', west, true]} forEach _camps;
        } forEach _nearTownsW;

        {
            _x setVariable ['sideID', east, true];
            _camps = synchronizedObjects _x;
            {_x setVariable ['sideID', east, true]} forEach _camps;
        } forEach _nearTownsE;
    };

    //--- Random towns (25% East, 25% West, 50% Res).
    case 3: {
        _limit = round(count activeTowns)/4;

        _near = activeTowns;
        for "_z" from 0 to _limit do {
            //--- Assign to west
            _r = random((count _near)-1);
            _nearTownsW append [_near select _r];
            _near = _near - [_near select _r];

            //--- Assign to east
            _r = random((count _near)-1);
            _nearTownsE append [_near select _r];
            _near = _near - [_near select _r];
        };


        //--- Benny removes pre placeed independent defences?
        {
            _x setVariable ['sideID', west, true];
            _camps = synchronizedObjects _x;
            {_x setVariable ['sideID', west, true]} forEach _camps;
        } forEach _nearTownsW;

        {
            _x setVariable ['sideID', east, true];
            _camps = synchronizedObjects _x;
            {_x setVariable ['sideID', east, true]} forEach _camps;
        } forEach _nearTownsE;

    };
};





//--- DEBUG CHECK TOWN SIDE WITH MARKER
{
    _name = _x getVariable "name";
    _m = createMarker [_name, position _x];
    _m setMarkerSize [100,100];
    _m setMarkerShape "ELLIPSE";
    _m setMarkerColor "ColorBlue";
} forEach _nearTownsW;

{
    _name = _x getVariable "name";
    _m = createMarker [_name, position _x];
    _m setMarkerSize [100,100];
    _m setMarkerShape "ELLIPSE";
    _m setMarkerColor "ColorRed";
} forEach _nearTownsE;

{
    _name = _x getVariable "name";
    _m = createMarker [_name, position _x];
    _m setMarkerSize [100,100];
    _m setMarkerShape "ELLIPSE";
    _m setMarkerColor "ColorGreen";
} forEach activeTowns - _nearTownsW - _nearTownsE;
