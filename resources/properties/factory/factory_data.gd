class_name FactoryData extends PropertyData

@export var passive_income: int = 20

func _init():
	type = ItemType.industry
	context_type = FactoryContext
	
func charge_rent(event: RentContext, turn: TurnContext, data: PropertyContext):
	super(event, turn, data)

func on_turn_end_event(
	event: TurnEndContext, 
	turn: TurnContext, 
	data: PropertyContext
):
	super(event, turn, data)
	if event.player == data._owner:
		data._owner.gain_or_spend_money(passive_income)
