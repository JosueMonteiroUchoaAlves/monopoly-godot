class_name PropertyData extends ItemData

@export var _price: int
@export var rent: int = 25

func _init() -> void:
	_needs_sub = true

func charge_rent(event: RentContext, turn: TurnContext, context: PropertyContext):
	check_context_format(context)
	event.payer.gain_or_spend_money(rent * -1)
	event.receiver.gain_or_spend_money(rent)
	event.payer_controller.skip_turn("Pagou aluguel")

func buy_property(event: BuyPropertyContext, turn: TurnContext, context: PropertyContext):
	# pra parar de disparar um erro ao definir o setter
	if event.buyer:
		if event.buyer.get_money() >= self._price:
			context._owner = event.buyer
			event.buyer.gain_or_spend_money(self._price * -1)
		else:
			print("Querer nao eh poder...")

func on_arrest_event(
	event: ArrestContext, 
	turn: TurnContext, 
	context: PropertyContext
):
	check_context_format(context)
	pass
	
func on_buy_property_event(
	event: BuyPropertyContext, 
	turn: TurnContext, 
	context: PropertyContext
):
	check_context_format(context)
	pass
	
func on_get_out_event(
	event: GetOutContext, 
	turn: TurnContext, 
	context: PropertyContext
):
	check_context_format(context)
	pass

func on_land_on_event(
	event: LandOnContext, 
	turn: TurnContext, 
	context: PropertyContext
):
	check_context_format(context)
	pass

func on_rent_event(
	event: RentContext, 
	turn: TurnContext, 
	context: PropertyContext
):
	check_context_format(context)
	pass

func on_step_over_event(
	event: StepOverContext, 
	turn: TurnContext, 
	context: PropertyContext
):
	check_context_format(context)
	pass
	
func on_turn_end_event(
	event: TurnEndContext, 
	turn: TurnContext, 
	context: PropertyContext
):
	check_context_format(context)
	pass
