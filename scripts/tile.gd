@abstract
class_name Tile extends Resource

@export var _property: Property

func _init(property: Property = null):
	_property = property

@abstract
func land_on(player: Player)
