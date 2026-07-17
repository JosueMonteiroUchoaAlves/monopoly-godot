class_name OilPlatformData extends PropertyData

@export var chance = 0.25

func _init():
	type = ItemType.exploration
	context_type = load("res://resources/properties/oil_platform/oil_platform_context.gd")
	
func charge_rent(event: RentContext, turn: TurnContext, context: PropertyContext):
	check_context_format(context)
	if not context.is_exploded:
		super(event, turn, context)
		var roll = randf()
		if roll < chance:
			context.is_exploded = true
			EventBus.round_log.emit("A plataforma de petróleo explodiu :/")
