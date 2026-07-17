class_name TechBroData extends TitleData

func _init():
	type = ItemType.industry
	context_type = TechBroContext
	
func on_land_on_event(
	event: LandOnContext, 
	turn: TurnContext, 
	data: TitleContext
):
	super(event, turn, data)
	if event.player == data.owner.player and event.tile.type == ItemType.industry:
		turn.nextController = data.owner
		turn.extra_turn = true
		
func on_buy_property_event(
	event: BuyPropertyContext, 
	turn: TurnContext, 
	data: TitleContext
):
	super(event, turn, data)
	if event.player == data.owner.player and event.tile.type == ItemType.industry:
		turn.nextController = data.owner
		turn.extra_turn = true
