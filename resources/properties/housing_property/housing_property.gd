class_name HousingPropertyData extends PropertyData

@export var rent: int = 25

func _init_():
	super._init()

func activate(payer: Player, receiver: Player):
	payer.gain_or_spend_money(rent * -1)
	receiver.gain_or_spend_money(rent)
