disableSerialization;
private ["_mainGrp","_display","_data","_value","_ctrl","_idx","_mainGrpPos","_group","_width","_pos"];
params ["_ctrl","_idx"];

_mainGrp = Epoch_interrupt_controls select 1;
_display = ctrlParent _mainGrp;
_data = _ctrl lbData _idx;
_value = _ctrl lbValue _idx;

Epoch_interrupt_index = _idx;
_mainGrpPos = ctrlPosition _mainGrp;
//_mainGrpPos set [0,Epoch_interrupt_offset]; //convert to global if having problems with x pos

ctrlDelete _mainGrp;

_mainGrp = _display ctrlCreate ["Epoch_main_config_group",_value];
_mainGrp ctrlSetPosition _mainGrpPos;
_mainGrp ctrlCommit 0;

_group = _display ctrlCreate [_data, _value + 1, _mainGrp];

_width = (ctrlPosition _group) select 2; 
Epoch_interrupt_controls set [1, _mainGrp];

{
	_pos = ctrlPosition _x;
	_pos set [2,_width];
	_x ctrlSetPosition _pos;
	_x ctrlCommit 0;
} forEach Epoch_interrupt_controls;

ctrlSetFocus _mainGrp;

true