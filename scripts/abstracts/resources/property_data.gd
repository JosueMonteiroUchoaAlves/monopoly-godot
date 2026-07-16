@abstract class_name PropertyData extends ItemData

@export var _price: int

func _init() -> void:
	_needs_sub = true

@abstract
func activate(payer: Player, receiver: Player)
