class_name ColonelData extends TitleData

func _init():
	type = ItemType.people
	context_type = ColonelContext
	
func on_land_on_event(
	event: LandOnContext, 
	turn: TurnContext, 
	context: TitleContext
):
	super(event, turn, context)
	if not context.owner:
		return
	
	if event.player != context.owner.player:
		var roll = randi_range(0, 2)
		if roll == 0:
			event.should_arrest = true
