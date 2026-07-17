class_name PropertyTileData extends GenericTileData

signal can_be_bought

func land_on(event: LandOnContext, turn: TurnContext, data: TileContext):
	super(event, turn, data)
	
	if data.property.player == null:
		can_be_bought.emit(self)
	else:
		data.property.charge_rent(player, data.property.owner)
