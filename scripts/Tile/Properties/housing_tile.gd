class_name HousingTile extends Tile
	

func _init(property: Property = null):
	super(property)

# antiga funcao activate
func land_on(player: Player):
	var owner = _property.get_owner()

	if owner:
		_property.charge_rent(player, owner)
	else:
		var prompt := "Você quer comprar {_property.get_name()} por {_property.get_price()}"
		var options := ["Sim", "Não"]
		print("Voce pousou na {_property.get_name()} mas nao tinha comprador")
		""" var d = Decision(prompt, options).promptDecision()
		if d == 0:
			_property.set_owner(player)
			player.gain_or_spend_money(_property.get_price() * -1)
			print("Você escolheu comprar {_property.get_name()}")
		else:
			print("Você escolheu não comprar")
		"""
