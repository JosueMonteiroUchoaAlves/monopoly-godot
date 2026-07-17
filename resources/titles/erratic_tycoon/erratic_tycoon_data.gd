class_name ErraticTycoonData extends TitleData

func _init():
	context_type = ErraticTycoonContext

func on_step_over_event(
	event: StepOverContext, 
	turn: TurnContext, 
	data: TitleContext
):
	super(event, turn, data)
	if event.player == data.owner.player:
		event.tile.land_on(data.owner)
