class_name Tile extends Node

@export var _property: Property
@export var base_data: GenericTileData

func _init(property: Property = null):
	_property = property
