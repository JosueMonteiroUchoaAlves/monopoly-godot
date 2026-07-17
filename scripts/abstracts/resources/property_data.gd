class_name PropertyData extends ItemData

@export var _price: int
@export var rent: int = 25
@export var is_corner: bool = false

func _init() -> void:
	_needs_sub = true

func charge_rent(event: RentContext, turn: TurnContext, data: PropertyContext):
	check_context_format(data)
	event.payer.gain_or_spend_money(rent * -1)
	event.receiver.gain_or_spend_money(rent)

func on_arrest_event(
	event: ArrestContext, 
	turn: TurnContext, 
	data: PropertyContext
):
	check_context_format(data)
	pass
	
func on_buy_property_event(
	event: BuyPropertyContext, 
	turn: TurnContext, 
	data: PropertyContext
):
	check_context_format(data)
	pass
	
func on_get_out_event(
	event: GetOutContext, 
	turn: TurnContext, 
	data: PropertyContext
):
	check_context_format(data)
	pass

func on_land_on_event(
	event: LandOnContext, 
	turn: TurnContext, 
	data: PropertyContext
):
	check_context_format(data)
	pass

func on_rent_event(
	event: RentContext, 
	turn: TurnContext, 
	data: PropertyContext
):
	check_context_format(data)
	pass

func on_step_over_event(
	event: StepOverContext, 
	turn: TurnContext, 
	data: PropertyContext
):
	check_context_format(data)
	pass
	
func on_turn_end_event(
	event: TurnEndContext, 
	turn: TurnContext, 
	data: PropertyContext
):
	check_context_format(data)
	pass
