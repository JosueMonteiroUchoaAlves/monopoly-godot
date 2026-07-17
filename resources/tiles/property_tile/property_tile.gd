@tool
class_name PropertyTileData extends GenericTileData

signal can_be_bought
signal charge_rent

func _init():
	context_type = PropertyTileContext
	type = ItemType.neutral
	
func land_on(event: LandOnContext, turn: TurnContext, context: PropertyTileContext):
	if context.property == null or context.property.get_ref() == null:
		event.controller.skip_turn("caiu em um lote vazio e não pôde fazer nada.")
		return
	var property = context.property.get_ref()
	if property.context._owner == null:
		event.controller.execute_turn(property)
	elif property.context._owner != event.player:
		event.should_charge = true
