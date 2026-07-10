@abstract
class_name Property extends Node

@export var _owner: Player : get=get_property_owner, set=set_property_owner
@export var _price: int :  get=get_property_price
@export var _name: String : get=get_property_name

func _init(name: String, price: int, owner: Player = null):
	_name = name
	_price = price
	_owner = owner

@abstract
func activate(payer: Player, receiver: Player)

func get_property_name():
	return _name
	
func get_property_price():
	return _price
	
func get_property_owner():
	return _owner
	
func set_property_owner(player: Player):
	_owner = player
