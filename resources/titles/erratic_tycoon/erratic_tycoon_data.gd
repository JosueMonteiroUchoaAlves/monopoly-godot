class_name ErraticTycoonData extends TitleData

func _init():
	context_type = ErraticTycoonContext

func on_step_over_event(
	event: StepOverContext, 
	turn: TurnContext, 
	context: TitleContext
):
	super(event, turn, context)
	if event.player == context.owner.player:
		event.tile.land_on(context.owner)
