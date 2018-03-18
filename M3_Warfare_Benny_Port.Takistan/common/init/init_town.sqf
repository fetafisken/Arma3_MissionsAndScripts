/*
LocationResupplyPoint_F
LocationCamp_F
Land_BagBunker_Large_F
Land_BagBunker_Tower_F
Land_BagBunker_Small_F
*/

Private ['_obj', '_depot', '_camps', '_type', '_dObj', '_cObj', '_m', '_name','_c'];
activeTowns = [];

//--- Set in editor
//waitUntil {createTown};

{
    //--- Control if the town is enabled by town amount.
    if ((text _x) in enabledTownLocations) then {
        _obj = nearestObjects [locationPosition  _x, ["LocationResupplyPoint_F"], 500];

        if (count _obj > 0)  then {
            _depot = (_obj select 0);

            if (_depot getVariable "enabled") then {
                _depot setVariable ["name", text _x, true];
                //-- _depot setVariable ["enabled", true, true]; already set in editor
                _depot setVariable ["sideID", resistance, true];

                _type = "Land_BagBunker_Large_F";
                _dObj = _type createVehicle [0,0,0];
                _dObj setPosATL (getPosATL _depot);
                _dObj setVectorDirAndUp [(vectorDir _depot),[0,0,1]];

                _name = _depot getVariable "name";
                _name = _name + " Depot";
                _m = createMarker [_name, position _dObj];
                _m setMarkerSize [1,1];
                _m setMarkerType "mil_box";
                _m setMarkerColor "ColorRed";

                _camps = synchronizedObjects _depot;
                _c = 0;
                {
                    _type = "";
                    if (typeOf _x == "LocationOutpost_F") then {
                        _type = "Land_BagBunker_Small_F";
                    } else {
                        if (typeOf _x == "LocationCamp_F") then {
                            _type = "Land_BagBunker_Tower_F";
                        };
                    };

                    if !(_type == "") then {
                        _name = _depot getVariable "name";
                        _name = _name + " Camp " + str(_c);
                        _c = _c + 1;

                        _cObj = _type createVehicle [0,0,0];
                        _cObj setPosATL (getPosATL _x);
                        _cObj setVectorDirAndUp [(vectorDir _x),[0,0,1]];
                        _cObj setVariable ["sideID", resistance, true];

                        _m = createMarker [_name, position _cObj];
                        _m setMarkerSize [1,1];
                        _m setMarkerType "mil_triangle";
                        _m setMarkerColor "ColorRed";
                    };
                } foreach _camps;
                activeTowns = activeTowns + [_depot];
            };
        };



        //--- DEBUG CHECK TOWN SIDE WITH MARKER

        _name = text _x + "t_marker";
        _m = createMarker [_name, position _x];
        _m setMarkerSize [200,200];
        _m setMarkerShape "RECTANGLE";
        _m setMarkerColor "COLORORANGE";

    };
} foreach towns;

//initTown = true;
_h = [] execVM "server\init\init_towns.sqf";


//--- Scales icons?
/*
ZOOM_MARKERS = ["MapMarker_1", ...];

(findDisplay 12) displayCtrl 51 ctrlAddEventHandler ["Draw",{
   _mapControl = _this select 0;
   _mapScale = ctrlMapScale _control;
   _zoomMarkers = ZOOM_MARKERS;
   for "_i" from 0 to ((count _zoomMarkers) - 1) do {
      _zoomMarker = _zoomMarkers select _i;
      if (_mapScale <= 0.1) then {
         _zoomMarker setMarkerAlphaLocal 1;
      } else {
         _zoomMarker setMarkerAlphaLocal 0;
      };
   };
};
*/
