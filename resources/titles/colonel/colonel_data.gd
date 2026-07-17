class_name ColonelData extends TitleData

func _init():
	type = ItemType.people
	context_type = ColonelContext
	
func on_land_on_event(
	event: LandOnContext, 
	turn: TurnContext, 
	data: TitleContext
):
	super(event, turn, data)
	if event.player != data.owner.player:
		var roll = randi_range(0, 2)
		if roll == 0:
			event.should_arrest = true
