class_name LandOnContext extends EventContext

var player: Player
var controller: Controller
var tile: WeakRef
var dice_roll: int
var should_arrest: bool
var should_charge: bool

func _init(
	_player: Player, 
	_controller: Controller, 
	_tile: WeakRef, 
	_dice_roll: int, 
	_should_arrest: bool
):
	player = _player
	controller = _controller
	tile = _tile
	dice_roll = _dice_roll
	should_arrest = _should_arrest
	should_charge = false
