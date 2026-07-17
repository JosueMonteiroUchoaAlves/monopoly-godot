class_name OilBaronData extends TitleData

func _init():
	type = ItemType.exploration
	context_type = OilBaronContext
	
func on_rent_event(
	event: RentContext, 
	turn: TurnContext, 
	data: TitleContext
):
	super(event, turn, data)
	if event.receiver == data.owner.player:
		event.modded_value = 1.1 * event.modded_value
