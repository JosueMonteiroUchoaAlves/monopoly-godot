class_name RentContext extends EventContext

var payer: Player
var payer_controller: Controller
var receiver: Player
var base_value: int
var modded_value: int

func _init(
	_payer: Player, 
	_receiver: Player, 
	_base_value: int, 
	_modded_value: int,
	_payer_controller: Controller
):
	payer = _payer
	receiver = _receiver
	base_value = _base_value
	modded_value = _modded_value
	payer_controller = _payer_controller
