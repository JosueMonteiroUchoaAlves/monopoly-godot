class_name KeyChangeData extends GenericTileData

@export var extra_money: int = 50

func _init():
	context_type = KeyChangeContext
	type = ItemType.neutral
	
func land_on(event: LandOnContext, turn: TurnContext, data: TileContext):
	super(event, turn, data)
	if not data.is_spent:
		event.player.gain_or_spend_money(extra_money)
		turn.nextController = event.controller
		turn.extra_turn = true
		data.is_spent = true
