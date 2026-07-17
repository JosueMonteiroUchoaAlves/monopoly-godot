class_name MafiosoData extends TitleData

@export var money: int = 60

func _init():
	type = ItemType.people
	context_type = ArtsPatronContext
	
func on_arrest_event(
	event: ArrestContext, 
	turn: TurnContext, 
	data: TitleContext
):
	super(event, turn, data)
	if event.player == data.owner.player and not event.is_cancelled:
		event.is_cancelled = true
		data.owner.player.gain_or_spend_money(money)
