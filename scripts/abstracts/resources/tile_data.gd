@abstract class_name GenericTileData extends ItemData

@export var board_texture: Texture2D

func _init() -> void:
	_needs_sub = true

@abstract
func activate(player: Player, context: TileContext)
