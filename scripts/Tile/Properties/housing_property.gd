class_name HousingProperty extends Property

var _rent: int

func _init(nameT: String, price: int, rent: int, ownerT = null):
	super(nameT, price, ownerT)
	_rent = rent
	
# antiga funcao activate
func charge_rent(payer: Controller):
	payer.player.gain_or_spend_money(_rent * -1)
	_owner.gain_or_spend_money(_rent)
	print("%s pagou %d a %s"% [payer.player.get_player_name(),_rent, _owner.get_player_name()])
