class_name PartyHallData extends PropertyData

func _init():
	type = ItemType.people
	context_type = PartyHallContext
	
func charge_rent(event: RentContext, turn: TurnContext, context: PropertyContext):
	super(event, turn, context)
	if event.payer not in context.debuffed_players:
		context.debuffed_players.append(event.payer)

func on_rent_event(
	event: RentContext, 
	turn: TurnContext, 
	context: PropertyContext
):
	super(event, turn, context)
	if event.payer == context._owner and (event.receiver in context.debuffed_players) and not event.is_cancelled:
		event.modded_value = 0
		event.is_cancelled = true
		context.debuffed_players.erase(event.payer)
