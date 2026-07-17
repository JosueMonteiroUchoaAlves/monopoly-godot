class_name BuyPropertyContext extends EventContext

var buyer: Player
var property: WeakRef
var base_value: int
var modded_value: int = base_value

func _init(_buyer: Player, _property: WeakRef, _base_value: int):
	buyer = _buyer
	property = _property
	base_value = _base_value
	modded_value = _base_value
