class_name OilBaronData extends TitleData

func _init():
	type = ItemType.exploration
	context_type = OilBaronContext
	
func on_rent_event(
	event: RentContext, 
	turn: TurnContext, 
	context: TitleContext
):
	super(event, turn, context)
	if event.receiver == context.owner.player:
		event.modded_value = 1.1 * event.modded_value
