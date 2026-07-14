class_name PropertyTile extends Tile
	
# sempre vai ter uma property, entao nunca vai ser null
func _init(property: Property):
	super(property)

# antiga funcao activate
func land_on(player_controller: Controller):
	var owner = _property.get_property_owner()

	if owner:
		print("Vish... a(o) %s tinha um dono!"%_property.get_property_name())
		_property.charge_rent(player_controller)
		print("Agora %s tem apenas %d reais!"%[player_controller.player.get_player_name(), player_controller.player.get_money()])
		# por enaquanto
		player_controller.skip_turn("nao ter mais o que fazer")
	else:
		print("Voce pousou na %s, mas ela nao tinha um dono..."%_property.get_property_name())
		#TODO: ver se ele quer comprar ela e tals	
		player_controller.execute_turn(_property)
