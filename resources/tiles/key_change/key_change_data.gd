class_name KeyChangeData extends GenericTileData

@export var extra_money: int = 50

func _init():
	context_type = KeyChangeContext
	type = ItemType.neutral
	
func land_on(event: LandOnContext, turn: TurnContext, context: TileContext):
	if not context.is_spent:
		event.player.gain_or_spend_money(extra_money)
		turn.nextController = event.controller
		turn.extra_turn = true
		context.is_spent = true
