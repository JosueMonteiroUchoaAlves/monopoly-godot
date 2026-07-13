class_name BoardNode extends Node2D

#@onready var personagem: Node2D = $Player
#@onready var inimigo: Node2D = $Enemy

@onready var _tiles: Array[TileNode] = [$Tile1, $Tile2, $Tile3, $Tile4, $Tile5, $Tile6, $Tile7, $Tile8, $Tile9, $Tile10, $Tile11, $Tile12]
@onready var _user_choice_UI: Control
var board_core: Board 
	
func _ready() -> void:
	print("Debug Logs - Board")

func setup(tiles: Array[Tile], players: Array[Controller], user_choice_UI_T: Control) -> void:
	_user_choice_UI = user_choice_UI_T
	board_core = Board.new(tiles, players)
	
	_user_choice_UI.player_choose.connect(on_player_choose)
	
# vai ficar aqui porque o player vai ser mover, porem de acordo com as coordenadas
# entregues pelo Board, pois o player nao precisa saber das tiles, quem tem que ter
# a lista de tiles eh o Board!
# OBS: na real eu voltei atras e por enquanto isso aqui nao funciona,
# no momento quem esta executando a turn 
func execute_turn():
	#TODO implementar skip - jogador pode escolher nao jogar
	var rng = RandomNumberGenerator.new()
	for controller: Controller in board_core._players:
		var initial_position: int = controller.player.get_position()
		
		var squares = rng.randi_range(0, 5) # squares = casas
		var new_position = (initial_position+squares) % board_core.SIZE
		# temos que usar global_position ao inves de apenas position, 
		# pois ele retornaria a posicao apenas em relacao ao pai direto dele (Que eh Tile, nao root	)
		var coordinates: Vector2 = _tiles[new_position].marker.global_position
		
		#controller.player.move(coordinates)
		
		#if initial_position != new_position:
		#	_tiles[new_position].land_on(controller.player)	
		#	controller.execute_turn()
		
		
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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

# currently not in use
func on_player_choose(choice):
	if choice == "buy":
		print("I think the player bought smh")
	else:
		if choice == "pass":
			print("Bro was too afraid to gamble")
		else:
			# Hacker choice?
			print("Tf is this guy doing??")
