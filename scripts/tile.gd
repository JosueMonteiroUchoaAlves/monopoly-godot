@abstract
class_name Tile extends RefCounted
# RefCounted eh basicamente um objeto cru, soh que ele se administra melhor sozinho do que um Object

@export var _property: Property

func _init(property: Property = null):
	_property = property

@abstract
func land_on(player: Player)
