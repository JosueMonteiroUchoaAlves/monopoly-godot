@abstract
class_name Tile extends Node

@export var _property: Property

func _init(property: Property = null):
	_property = property

@abstract
func activate(player: Player)
