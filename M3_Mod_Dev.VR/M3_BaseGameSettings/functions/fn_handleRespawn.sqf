_newUnit = _this select 0;
_oldUnit = _this select 1;


if(_newUnit == leader _newUnit && _newUnit == player) then {
	_act = _newUnit addAction ["<t color='#FF0000'>Rallypoint</t>", M3_fnc_deployRally];
};

if(_oldUnit != objNull) then {
	removeAllActions _oldUnit;
};
