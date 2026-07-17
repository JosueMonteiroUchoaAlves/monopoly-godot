class_name StartTileData extends GenericTileData

@export var start_money: int = 50

func _init():
	context_type = StartTileContext
	type = ItemType.neutral

func step_over(event: StepOverContext, turn: TurnContext, data: TileContext):
	super(event, turn, data)
	event.player.gain_or_spend_money(start_money)
