class_name StartTileData extends GenericTileData

@export var start_money: int = 50

func _init():
	context_type = StartTileContext
	type = ItemType.neutral
	is_corner = true

func land_on(event: LandOnContext, turn: TurnContext, context: StartTileContext):
	event.controller.skip_turn("não tinha nada pra fazer")

func step_over(event: StepOverContext, turn: TurnContext, context: TileContext):
	event.player.gain_or_spend_money(start_money)
