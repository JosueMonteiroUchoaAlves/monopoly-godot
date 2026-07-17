class_name TitleData extends ItemData

@export var sidebar_texture: Texture2D

func on_arrest_event(
	event: ArrestContext, 
	turn: TurnContext, 
	data: TitleContext
):
	check_context_format(data)
	pass
	
func on_buy_property_event(
	event: BuyPropertyContext, 
	turn: TurnContext, 
	data: TitleContext
):
	check_context_format(data)
	pass
	
func on_get_out_event(
	event: GetOutContext, 
	turn: TurnContext, 
	data: TitleContext
):
	check_context_format(data)
	pass

func on_land_on_event(
	event: LandOnContext, 
	turn: TurnContext, 
	data: TitleContext
):
	check_context_format(data)
	pass

func on_rent_event(
	event: RentContext, 
	turn: TurnContext, 
	data: TitleContext
):
	check_context_format(data)
	pass

func on_step_over_event(
	event: StepOverContext, 
	turn: TurnContext, 
	data: TitleContext
):
	check_context_format(data)
	pass
	
func on_turn_end_event(
	event: TurnEndContext, 
	turn: TurnContext, 
	data: TitleContext
):
	check_context_format(data)
	pass
