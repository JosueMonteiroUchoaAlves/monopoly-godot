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

func execute_turn(tile_position: int, player: Controller):
	# Qualquer tile vai ter um logic_core que recebe um controller
	# nao lembro porque mantive aquela condicional... lmfao
	_tiles[tile_position].logic_core.land_on(player) # Controller do player

func expropriation_of_assets(bankruptPlayer: Player):
	for tile in _tiles:
		if tile.logic_core is PropertyTile:
			if tile.logic_core._property.get_property_owner() == bankruptPlayer:
				tile.logic_core._property._owner = null
