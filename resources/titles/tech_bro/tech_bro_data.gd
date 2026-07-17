class_name TechBroData extends TitleData

func _init():
	type = ItemType.industry
	context_type = TechBroContext
	
func on_land_on_event(
	event: LandOnContext, 
	turn: TurnContext, 
	context: TitleContext
):
	super(event, turn, context)
	if event.player == context.owner.player and event.tile.type == ItemType.industry:
		turn.nextController = context.owner
		turn.extra_turn = true
		
func on_buy_property_event(
	event: BuyPropertyContext, 
	turn: TurnContext, 
	context: TitleContext
):
	super(event, turn, context)
	if event.player == context.owner.player and event.tile.type == ItemType.industry:
		turn.nextController = context.owner
		turn.extra_turn = true
