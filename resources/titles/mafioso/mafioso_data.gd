class_name MafiosoData extends TitleData

@export var money: int = 60

func _init():
	type = ItemType.people
	context_type = ArtsPatronContext
	
func on_arrest_event(
	event: ArrestContext, 
	turn: TurnContext, 
	context: TitleContext
):
	super(event, turn, context)
	if event.player == context.owner.player and not event.is_cancelled:
		event.is_cancelled = true
		context.owner.player.gain_or_spend_money(money)
