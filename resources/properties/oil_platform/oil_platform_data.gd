class_name OilPlatformData extends PropertyData

@export var chance = 0.25

func _init():
	type = ItemType.exploration
	context_type = OilPlatformContext
	
func charge_rent(event: RentContext, turn: TurnContext, data: PropertyContext):
	check_context_format(data)
	if not data.is_exploded:
		super(event, turn, data)
		var roll = randf()
		if roll < chance:
			data.is_exploded = true
