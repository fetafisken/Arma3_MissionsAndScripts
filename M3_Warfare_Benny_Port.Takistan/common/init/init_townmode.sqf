


//--- All towns in takistan
/*
["Anar","Falar","Feruz Abad","Kakaru","Imarat","Timurkalay","Garmarud","Bastam",
"Sakhe","Gospandi","Garmsar","Jilavur","Sultansafe","Loy Manara",
"Mulladost","Rasman","Jaza","Huzrutimam","Nagara","Khushab","Ravanay",
"Chardarakht","Shukurkalay","Chak Chak","Shamali",
"Zavarak","Chaman","Karachinar","Nur","Landay"]
*/

_townAmount = "townsAmount" call BIS_fnc_getParamValue;
switch (_townAmount) do {

    //--- XS 6 towns
    case 0: {
        enabledTownLocations = ["Feruz Abad","Bastam", "Sakhe","Loy Manara","Rasman","Chak Chak"];
    };

    //--- S 10 towns
    case 1: {
        enabledTownLocations = ["Feruz Abad","Bastam","Sakhe","Loy Manara","Rasman","Chak Chak","Garmsar","Nagara","Zavarak","Chaman"];
    };

    //--- M 14 towns
    case 2: {
        enabledTownLocations = ["Feruz Abad","Bastam","Sakhe","Loy Manara","Rasman","Chak Chak","Garmsar","Nagara","Zavarak","Chaman","Anar","Falar","Garmarud","Mulladost"];
    };

    //--- L 20 towns
    case 3: {
        enabledTownLocations = ["Feruz Abad","Bastam","Sakhe","Loy Manara","Rasman","Chak Chak","Garmsar","Nagara","Zavarak","Chaman","Anar","Falar","Garmarud","Mulladost","Timurkalay","Khushab","Chardarakht","Nur","Shamali","Huzrutimam"];
    };

    //--- F 30 towns
    case 4: {
        enabledTownLocations = ["Anar","Falar","Feruz Abad","Kakaru","Imarat","Timurkalay","Garmarud","Bastam","Sakhe","Gospandi","Garmsar","Jilavur","Sultansafe","Loy Manara","Mulladost","Rasman","Jaza","Huzrutimam","Nagara","Khushab","Ravanay","Chardarakht","Shukurkalay","Chak Chak","Shamali","Zavarak","Chaman","Karachinar","Nur","Landay"];
    };
};

_h = [] execVM "common\init\init_town.sqf";
