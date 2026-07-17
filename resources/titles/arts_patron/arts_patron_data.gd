class_name ArtsPatronData extends TitleData

func _init():
	type = ItemType.arts
	context_type = ArtsPatronContext
	
func on_buy_property_event(
	event: BuyPropertyContext, 
	turn: TurnContext, 
	context: TitleContext
):
	super(event, turn, context)
	if event.property.type == ItemType.arts and event.buyer == context.owner.player:
		context.is_free = true

func on_land_on_event(
	event: LandOnContext, 
	turn: TurnContext, 
	context: TitleContext
):
	super(event, turn, context)
	if event.property.type == ItemType.arts and event.player == context.owner.player:
		context.is_free = true
		
func on_rent_event(
	event: RentContext, 
	turn: TurnContext, 
	context: TitleContext
):
	super(event, turn, context)
	if context.is_free and (not event.is_cancelled) and event.payer == context.owner.player:
		event.modded_value = 0
		event.is_cancelled = true
		context.is_free = false
