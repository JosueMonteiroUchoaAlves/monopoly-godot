class_name PartyHallData extends PropertyData

func _init():
	type = ItemType.people
	context_type = PartyHallContext
	
func charge_rent(event: RentContext, turn: TurnContext, data: PropertyContext):
	super(event, turn, data)
	if event.payer not in data.debuffed_players:
		data.debuffed_players.append(event.payer)

func on_rent_event(
	event: RentContext, 
	turn: TurnContext, 
	data: PropertyContext
):
	super(event, turn, data)
	if event.payer == data._owner and (event.receiver in data.debuffed_players) and not event.is_cancelled:
		event.modded_value = 0
		event.is_cancelled = true
		data.debuffed_players.erase(event.payer)
