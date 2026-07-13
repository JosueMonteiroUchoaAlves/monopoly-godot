class_name Round extends Node2D

@onready var user_choice_UI: Control = $Control
@onready var board: BoardNode = $Board

var main_player: MainController
var bot_players: Array[BotController] = []
var players: Array[Controller] = []
var tiles: Array[Tile]
var player_nodes: Array[PlayerNode]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# -1 quer dizer que esta fora da board
	# TODO: adicionar a casa inicial, ai aqui vai ser 0 mesmo
	var jogador = Player.new("Jogador", 240, -1)
	
	var properties = [
		"Vila Sésamo", 
		"Gotham City", 
		"Hometown (Deltarune)",
		"Bora Bill Eventos",
		"Horizonte Solar",
		"Santo Berço",
		"Coroa de Espinhos",
		"Crazy Noisy Bizarre Town",
		"O Escritório (do ingles The Office)",
		"Hangar 18",
		"Fórum do StackOverflow",
		"Bomba de Etanol"
	]

	for i in range(Board.SIZE):
		var property = HousingProperty.new(properties[i], 60, 60)
		var tile = HousingTile.new(property)
		#TODO: linkar tiles com seus respectivos Nodes2D
		tiles.append(tile)
	
	player_nodes = board.get_players()
	for player_node in player_nodes:
		var player_core = Player.new(str("Bot %s"% player_node.name), 240, -1)
		if player_node.is_enemy:
			var controller = BotController.new(player_core, player_node)
			bot_players.append(controller)
		else:
			main_player = MainController.new(jogador, player_node)
		
	players.assign(bot_players)
	players.append(main_player)
	
	# vai servir futuramente para mover a partida para board
	board.setup(tiles, players, user_choice_UI)
	
	start_round()
	
func start_round() -> void:
	var _tiles: Array[TileNode] = board.get_children_tiles()
	var rng = RandomNumberGenerator.new()
	var current_turn_index: int = 0
	
	#TODO: o player perde
	while main_player.player.get_money() < 400:
		var current_player: Controller = players[current_turn_index]
		
		var initial_position: int = current_player.player.get_player_position()
		
		var squares = rng.randi_range(0, 3) # squares = casas
		var new_position: int = (initial_position+squares) % Board.SIZE
		print("Ele se movera %d casas"%squares)
		# temos que usar global_position ao inves de apenas position, 
		# pois ele retornaria a posicao apenas em relacao ao pai direto dele (Que eh Tile, nao root	)
		var coordinates: Vector2 = _tiles[new_position].marker.global_position
		
		# move para a nova casa
		#-- Logicamente
		current_player.player.move(new_position)
		#-- Visualmente
		current_player.view.move(coordinates)
		
		# pra dar tempo de conferir se moveu certinho
		await get_tree().create_timer(2.0).timeout
		
		#TODO: ver se ele quer comprar ela e tals
		current_player.execute_turn()
		
		print("Turno de %s ainda nao encerrou"% current_player.player.get_player_name())
		await current_player.turn_finished
		print("Turno de %s encerrado"% current_player.player.get_player_name())
		
		current_turn_index = (current_turn_index + 1) % players.size()
		
	print("Fim de jogo! Você ganhou")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
