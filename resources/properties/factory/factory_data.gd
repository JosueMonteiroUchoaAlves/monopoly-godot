class_name FactoryData extends PropertyData

@export var passive_income: int = 20

func _init():
	type = ItemType.industry
	context_type = FactoryContext
	
func charge_rent(event: RentContext, turn: TurnContext, context: PropertyContext):
	super(event, turn, context)

func on_turn_end_event(
	event: TurnEndContext, 
	turn: TurnContext, 
	context: PropertyContext
):
	super(event, turn, context)
	if event.player == context._owner:
		context._owner.gain_or_spend_money(passive_income)
