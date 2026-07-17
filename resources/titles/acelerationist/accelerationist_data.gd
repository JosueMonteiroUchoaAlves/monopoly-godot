class_name AccelerationistData extends TitleData

func _init():
	type = ItemType.neutral
	context_type = AccelerationistContext
	
func on_buy_property_event(
	event: BuyPropertyContext, 
	turn: TurnContext, 
	context: TitleContext
):
	super(event, turn, context)
	if event.player == context.owner.player:
		event.modded_value = 1.25 * event.modded_value
		turn.nextController = context.owner
		turn.extra_turn = true
