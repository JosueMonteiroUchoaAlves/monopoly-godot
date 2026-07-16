class_name Property extends Node

@export var _owner: Player : get=get_property_owner, set=set_property_owner
@export var _base_data: PropertyData
	
func get_property_owner():
	return _owner
	
func set_property_owner(player: Player):
	_owner = player
