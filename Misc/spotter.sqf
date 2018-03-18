
/*
	File: fn_spotter.sqf
	Author: Karel Moricky

	Description:
	Spotter reprting target distance to sniper

	Parameter(s):
	_this:	OBJECT	- sniper
		OBJECT	- spotter

	Returns:
	Nothing
*/
_sniper = _this select 0;
_spotter = _this select 1;

{
	_x kbaddtopic ["BIS_distanceReport","A3\functions_f\systems\fn_spotter.bikb",""];
} foreach [_sniper,_spotter];

_numberToString = {
	_number = _this;
	_result = switch _number do {
		case 0: {"AnThis"};
		case 1: {"AnThis"};
		case 2: {"CommStealth"};
		case 3: {"three"};
		case 4: {"four"};
		case 5: {"five"};
		case 6: {"six"};
		case 7: {"seven"};
		case 8: {"eight"};
		case 9: {"nine"};
		default {"zero"};
	};
	_result;
};

_distToVoice = {
	_hundred = _this select 0;
	_ten = _this select 1;
	_one = _this select 2;


	_result = switch _hundred do {
		case 1: {["one"]};
		case 2: {["two"]};
		case 3: {["three"]};
		case 4: {["four"]};
		case 5: {["five"]};
		case 6: {["six"]};
		case 7: {["seven"]};
		case 8: {["eight"]};
		case 9: {["nine"]};
		
		case 10: {["ten"]};
		case 11: {["eleven"]};
		case 12: {["twelve"]};
		case 13: {["thirteen"]};
		case 14: {["fourteen"]};
		case 15: {["fifteen"]};
		case 16: {["sixteen"]};
		case 17: {["seventeen"]};
		case 18: {["eighteen"]};
		case 19: {["nineteen"]};
		
		case 20: {["twenty"]};
		case 21: {["twenty","one"]};
		case 22: {["twenty","two"]};
		case 23: {["twenty","three"]};
		case 24: {["twenty","four"]};
		case 25: {["twenty","five"]};
		case 26: {["twenty","six"]};
		case 27: {["twenty","seven"]};
		case 28: {["twenty","eight"]};
		case 29: {["twenty","nine"]};

		case 30: {["thirty"]};
		case 31: {["thirty","one"]};
		case 32: {["thirty","two"]};
		case 33: {["thirty","three"]};
		case 34: {["thirty","four"]};
		case 35: {["thirty","five"]};
		case 36: {["thirty","six"]};
		case 37: {["thirty","seven"]};
		case 38: {["thirty","eight"]};
		case 39: {["twenty","nine"]};

		case 40: {["forty"]};
		case 41: {["forty","one"]};
		case 42: {["forty","two"]};
		case 43: {["forty","three"]};
		case 44: {["forty","four"]};
		case 45: {["forty","five"]};
		case 46: {["forty","six"]};
		case 47: {["forty","seven"]};
		case 48: {["forty","eight"]};
		case 49: {["forty","nine"]};

		case 50: {["fifty"]};
		default {[""]};
	};

	if (_hundred > 0) then {_result = _result + ["hundred"]; };

	_r = switch _ten do {
		case 1: {["ten"]};
		case 2: {["twenty"]};
		case 3: {["thirty"]};
		case 4: {["forty"]};
		case 5: {["fifty"]};
		case 6: {["sixty"]};
		case 7: {["seventy"]};
		case 8: {["eightty"]};
		case 9: {["ninety"]};
		default {[""]};
	};

	_result = _result + _r;

	_r = switch _one do {
		case 1: {["one"]};
		case 2: {["two"]};
		case 3: {["three"]};
		case 4: {["four"]};
		case 5: {["five"]};
		case 6: {["six"]};
		case 7: {["seven"]};
		case 8: {["eight"]};
		case 9: {["nine"]};
	};

	_result = _result + _r;

	/*
		case 1: {"dist100"};
		case 2: {"dist200"};
		case 3: {"dist300"};
		case 4: {"dist400"};
		case 5: {"dist500"};
		case 6: {"dist600"};
		case 7: {"dist700"};
		case 8: {"dist800"};
		case 9: {"dist900"};
		case 10: {"dist1000"};
		case 15: {"dist1500"};
		case 20: {"dist2000"};
		case 25: {"dist2500"};
		default {""};
	*/


	_result;
};

_array = [];
_teamDistanceMax = 50;
_dis = 0;
_c = 0;
while {alive _sniper && alive _spotter && _c < 4} do {
	if (player == _sniper) then {
		if (cameraview == "GUNNER") then {
			if (_sniper distance _spotter < _teamDistanceMax) then {
				if !(isnull cursorObject) then {
					_disTemp = _sniper distance cursorObject;
					_disRel = abs (_dis - _disTemp);
					_type = cursorObject call BIS_fnc_objectType select 1;

					if (_disRel > 25 && _disTemp >= 25) then {
						//_disText = (round (_disTemp / 100)) * 100;
						_disText = round _disTemp;
						_disText0001 = (_disText % 10);
						_disText0010 = (_disText % 100 - _disText0001);
						_disText0100 = (_disText % 1000 - _disText0001 - _disText0010);
						_disText1000 = (_disText - _disText0100 - _disText0001 - _disText0010);
						_disText0001 = _disText0001 / 0001;
						_disText0010 = _disText0010 / 0010;
						_disText0100 = _disText0100 / 0100;
						_disText1000 = _disText1000 / 1000;


						//_speechArray = [];
						_speechArray = [[_disText1000 + _disText0100, _disText0010, _disText0001]call _distToVoice];

						if (_disText >= 1000) then {_speechArray = _speechArray + [_disText1000 call _numberToString]};
						if (_disText >= 0100) then {_speechArray = _speechArray + [_disText0100 call _numberToString]};
						if (_disText >= 0010) then {_speechArray = _speechArray + [_disText0010 call _numberToString]};
						if (_disText >= 0001) then {_speechArray = _speechArray + [_disText0001 call _numberToString]};
						_speechArray = ([_disText1000 + _disText0100, _disText0010, _disText0001] call _distToVoice);
						_speechArray = _speechArray + ["Meters"];
						
						
						if !(_type == "") then {_type = _type + ", "; };
						_str = _type + str(_disText) + "m";
						hint format ["%1",_speechArray];

						_sentence = [_sniper,"BIS_distanceReport","distanceReport",["Dist",{},_str,_speechArray], 'DIRECT'];
						_spotter kbtell _sentence;

						
					};
					_dis = _disTemp;
				};
			};
		};
	};
	sleep 3;
	_c = _c + 1;
};
