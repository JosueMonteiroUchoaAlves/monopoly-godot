class_name TemplateTitleData extends TitleData

func _init():
	type = ItemType.industry
	context_type = TemplateTitleContext
	
func on_land_on_event(
	event: LandOnContext, 
	turn: TurnContext, 
	data: TitleContext
):
	super(event, turn, data)
	if event.player == data.owner.player and event.tile.type == ItemType.industry:
		turn.nextController = data.owner
		turn.extra_turn = true
