class_name ArtsPatronData extends TitleData

func _init():
	type = ItemType.arts
	context_type = ArtsPatronContext
	
func on_buy_property_event(
	event: BuyPropertyContext, 
	turn: TurnContext, 
	data: TitleContext
):
	super(event, turn, data)
	if event.property.type == ItemType.arts and event.buyer == data.owner.player:
		data.is_free = true

func on_land_on_event(
	event: LandOnContext, 
	turn: TurnContext, 
	data: TitleContext
):
	super(event, turn, data)
	if event.property.type == ItemType.arts and event.player == data.owner.player:
		data.is_free = true
		
func on_rent_event(
	event: RentContext, 
	turn: TurnContext, 
	data: TitleContext
):
	super(event, turn, data)
	if data.is_free and (not event.is_cancelled) and event.payer == data.owner.player:
		event.modded_value = 0
		event.is_cancelled = true
		data.is_free = false
