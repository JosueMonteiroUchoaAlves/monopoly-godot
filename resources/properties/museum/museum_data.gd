class_name MuseumData extends PropertyData

@export var money_per_art: int = 20

func _init():
	type = ItemType.arts
	context_type = MuseumContext
	
func charge_rent(event: RentContext, turn: TurnContext, data: PropertyContext):
	super(event, turn, data)
	if is_instance_of(data._owner, MainController):
		var art_count = 0
		for key in data._owner.inventory:
			for item in data._owner.inventory[key]:
				if item.type == ItemType.arts:
					art_count += 1
		var extra_value = art_count * money_per_art
		event.payer.gain_or_spend_money(extra_value * -1)
		data._owner.gain_or_spend_money(extra_value)
