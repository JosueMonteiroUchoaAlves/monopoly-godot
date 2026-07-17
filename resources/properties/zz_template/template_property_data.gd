class_name TemplatePropertyData extends PropertyData

func _init():
	type = ItemType.neutral
	context_type = TemplatePropertyContext
	
func charge_rent(event: RentContext, turn: TurnContext, context: PropertyContext):
	super(event, turn, context)
