class_name TemplateTitleData extends TitleData

func _init():
	type = ItemType.industry
	context_type = TemplateTitleContext
	
func on_land_on_event(
	event: LandOnContext, 
	turn: TurnContext, 
	context: TitleContext
):
	super(event, turn, context)
	if event.player == context.owner.player and event.tile.type == ItemType.industry:
		turn.nextController = context.owner
		turn.extra_turn = true
