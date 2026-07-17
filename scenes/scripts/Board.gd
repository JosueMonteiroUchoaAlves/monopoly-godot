class_name BoardNode extends Node2D

@onready var _user_choice_UI: Control
var tiles: Array[TileNode]
var board_core: Board 
	
func _ready() -> void:
	tiles = get_children_tiles()

func setup(setup_tiles: Array[LogicTile], players: Array[Controller], user_choice_UI_T: Control) -> void:
	_user_choice_UI = user_choice_UI_T
	board_core = Board.new(setup_tiles, players)
	
	for i in range(Board.SIZE):
		# linkar TileNode com seu respectivo tile
		tiles[i].logic_core = setup_tiles[i]
		
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
	var logic_tile = tiles[tile_position].logic_core
	logic_tile.data.land_on(player) # Controller do player

func expropriation_of_assets(bankruptPlayer: Player):
	for tile in tiles:
		if tile.logic_core.data is PropertyTileData:
			if tile.logic_core.context.property.context._owner == bankruptPlayer:
				tile.logic_core.context.property.context._owner = null

func get_safe_drop_coordinate(target_tile_index: int) -> Vector2:
	var base_coordinate: Vector2 = tiles[target_tile_index].marker.global_position
	
	# Conta quantos jogadores já estão nessa casa
	var occupants: int = 0
	for controller in board_core._players:
		if not controller.is_bankrupt and controller.player.get_player_position() == target_tile_index:
			occupants += 1
			
	# Aplica um deslocamento (offset) baseado na ordem de chegada
	var offset := Vector2.ZERO
	match occupants:
		0: offset = Vector2.ZERO # Primeiro a chegar fica no centro
		1: offset = Vector2(-15, -15) # Segundo chega um pouco pra cima/esquerda
		2: offset = Vector2(15, 15) # Terceiro pra baixo/direita
		3: offset = Vector2(-15, 15) # Quarto pro outro lado
		_: offset = Vector2(randf_range(-20, 20), randf_range(-20, 20)) # Se tiver mais, joga aleatório
		
	return base_coordinate + offset
