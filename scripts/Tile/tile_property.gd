class_name PropertyTile extends Tile

# sempre vai ter uma property, entao nunca vai ser null
func _init(property: Property):
	super(property)

# antiga funcao activate
func land_on(player_controller: Controller):
	var owner = _property.get_property_owner()

	if owner:
		round_log("Vish... a(o) %s tinha um dono!"%_property.get_property_name())
		
		if owner == player_controller.player:
			round_log("mas o dono era ele mesmo! ufa")
		else:
			_property.charge_rent(player_controller)
			if player_controller.player.get_money() < 0:
				player_controller.file_for_bankruptcy() # colocar em spend money do player? - caio
			else:
				round_log("Agora %s tem apenas %d reais!"%[player_controller.player.get_player_name(), player_controller.player.get_money()])
			
		# por enquanto
		player_controller.skip_turn("nao ter mais o que fazer")
	else:
		round_log("Voce pousou na %s, mas ela nao tinha um dono..."%_property.get_property_name())
		player_controller.execute_turn(_property)

func round_log(text: String):
	EventBus.round_log.emit(text)
