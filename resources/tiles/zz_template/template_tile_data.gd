class_name TemplateTileData extends GenericTileData

func _init():
	context_type = TemplateTileContext
	type = ItemType.neutral
	
func land_on(event: LandOnContext, turn: TurnContext, data: TileContext):
	super(event, turn, data)
