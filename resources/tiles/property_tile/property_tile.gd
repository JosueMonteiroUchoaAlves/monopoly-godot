class_name PropertyTileData extends GenericTileData

signal can_be_bought
signal charge_rent

func _init():
	context_type = PropertyTileContext
	type = ItemType.neutral

func land_on(event: LandOnContext, turn: TurnContext, context: PropertyTileContext):
	var property = context.property.get_ref()
	if property.context._owner == null:
		event.controller.execute_turn(property)
	elif property.context._owner != event.player:
		event.should_charge = true
