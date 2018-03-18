class CfgVehicles
{
	class Logic;
	class Module_F: Logic
	{
		class AttributesBase
		{
			class Default;
			class Edit; // Default edit box (i.e., text input field)
			class Combo; // Default combo box (i.e., drop-down menu)
			class Checkbox; // Default checkbox (returned value is Bool)
			class CheckboxNumber; // Default checkbox (returned value is Number)
			class ModuleDescription; // Module description
		};
		// Description base classes, for more information see below
		class ModuleDescription
		{
			class EmptyDetector ;
		};
	};
	class M3_RallypointSetup: Module_F
	{
		// Standard object definitions
		scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
		displayName = "Rallypoint Setup"; // Name displayed in the menu
		//icon = ""; // Map icon. Delete this entry to use the default icon
		category = "M3_Module_Category";

		// Name of function triggered once conditions are met
		function = "M3_fnc_initMod";

		// Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
		functionPriority = 0;

		// 0 for server only execution, 1 for global execution, 2 for persistent global execution
		isGlobal = 0;

		// 1 for module waiting until all synced triggers are activated
		//isTriggerActivated = 1;

		// 1 if modules is to be disabled once it's activated (i.e., repeated trigger activation won't work)
		//isDisposable = 1;

		// // 1 to run init function in Eden Editor as well
		is3DEN = 1;

		// Menu displayed when the module is placed or double-clicked on by Zeus
		//curatorInfoType = "RscDisplayAttributes";

		// Module attributes, uses https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes#Entity_Specific
		class Attributes: AttributesBase
		{
			class Object: Combo
  			{
				// Unique property, use "<moduleClass>_<attributeClass>" format to make sure the name is unique in the world
				property = "M3_Rallypoint_Object";
				displayName = "Rallypoint Object"; // Argument label
				tooltip = "Object which will act as the rallypoint."; // Tooltip description
				typeName = "STRING"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				class Values
				{
					class Tent {name = "Tent"; value = "Land_TentA_F";};
					class DomeTent {name = "Dome Tent"; value = "Land_TentDome_F";};
					class SleepingBag {name = "SleepingBag"; value = "Land_Sleeping_bag_brown_F";};
					class Toilet {name = "Toilet"; value = "Land_ToiletBox_F";};
				};
				defaultValue = "Land_TentA_F"; // Default attribute value. WARNING: This is an expression, and its returned value will be used (50 in this case)

			};
			class TPR: Edit
  			{
				property = "M3_Rallypoint_TPR";
				displayName = "Tickets Per Rallypoint";
				tooltip = "How many tickets per rallypoint";
				defaultValue = 10;
			};



			class Side: Combo
  			{
				// Unique property, use "<moduleClass>_<attributeClass>" format to make sure the name is unique in the world
				property = "M3_Rallypoint_Side";
				displayName = "Player Side"; // Argument label
				tooltip = "Which side players are on, used with the respawn tickets under"; // Tooltip description
				typeName = "STRING"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				class Values
				{
					class west {name = "Blufor"; value = "west";};
					class east {name = "Opfor"; value = "east";};
					class resistance {name = "Independent"; value = "resistance";};
					class civilian {name = "Civilian"; value = "civilian";};
				};
				defaultValue = "west"; // Default attribute value. WARNING: This is an expression, and its returned value will be used (50 in this case)

			};
			class SideTickets: Edit
			{
				property = "M3_Rallypoint_Side_Tickets";
				displayName = "Start tickets for player side";
				tooltip = "Number of tickets for players side. -1 to disable module settings";
				defaultValue = 30;
			};




			class ModuleDescription: ModuleDescription{}; // Module description should be shown last
		};

		//Module description. Must inherit from base class, otherwise pre-defined entities won't be available
		class ModuleDescription: ModuleDescription
		{
			description = "Used to initialize the rallypoint functionality"; // Short description, will be formatted as structured text
		};
	};
};
