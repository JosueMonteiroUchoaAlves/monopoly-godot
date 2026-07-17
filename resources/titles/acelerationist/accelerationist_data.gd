class_name AccelerationistData extends TitleData

func _init():
	type = ItemType.neutral
	context_type = AccelerationistContext
	
func on_buy_property_event(
	event: BuyPropertyContext, 
	turn: TurnContext, 
	data: TitleContext
):
	super(event, turn, data)
	if event.player == data.owner.player:
		event.modded_value = 1.25 * event.modded_value
		turn.nextController = data.owner
		turn.extra_turn = true
