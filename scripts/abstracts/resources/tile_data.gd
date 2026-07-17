class_name GenericTileData extends ItemData

@export var board_texture: Texture2D

func _init() -> void:
	_needs_sub = true

func land_on(event: LandOnContext, turn: TurnContext, data: TileContext):
	check_context_format(data)

func step_over(event: StepOverContext, turn: TurnContext, data: TileContext):
	check_context_format(data)
