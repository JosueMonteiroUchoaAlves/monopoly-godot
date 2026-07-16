class_name PropertyTile extends GenericTileData

signal can_be_bought

# TODO: Refactor this to be wayy better cuz right now it's kinda dumb
func activate(player: Player, context: TileContext):
	assert(context is PropertyTileContext, "Context must be of it's type")
	
	if context.property.player == null:
		can_be_bought.emit(self)
	else:
		context.property.activate(player, context.property.owner)
