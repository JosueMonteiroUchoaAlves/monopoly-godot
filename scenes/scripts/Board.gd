class_name BoardNode extends Node2D

@onready var _user_choice_UI: Control
var _tiles: Array[TileNode]
var board_core: Board 
	
func _ready() -> void:
	print("Debug Logs - Board")
	_tiles = get_children_tiles()

func setup(tiles: Array[Tile], players: Array[Controller], user_choice_UI_T: Control) -> void:
	_user_choice_UI = user_choice_UI_T
	board_core = Board.new(tiles, players)
	
	for i in range(Board.SIZE):
		# linkar TileNode com seu respectivo tile
		_tiles[i].logic_core = tiles[i]
		
func get_children_tiles() -> Array[TileNode]:
	var tiles: Array[TileNode] = []
	
	for child in get_children():
		if child is TileNode:
			tiles.append(child)
	return tiles
	
func get_players() -> Array[PlayerNode]:
	var tiles: Array[PlayerNode] = []
	
	for child in get_children():
		if child is PlayerNode:
			tiles.append(child)
	return tiles

func activate_on_step(tile_position: int, player: Controller):
	if _tiles[tile_position].logic_core._property != null: # Eh uma propriedade
		var propertyTile = (_tiles[tile_position].logic_core as PropertyTile)
		propertyTile.land_on(player)
	else:
		# nao sendo uma propriedade... por enquanto nao faz nada 
		pass
