class_name HousingPropertyData extends PropertyData

func _init_():
	super._init()

func charge_rent(event: RentContext, turn: TurnContext, data: PropertyContext):
	super(event, turn, data)
