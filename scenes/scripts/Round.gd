class_name Round extends Node2D

@onready var user_choice_UI: Control = $Control
@onready var board: BoardNode = $Board

var main_player: MainController
var bot_players: Array[BotController] = []
var players: Array[Controller] = []
var tiles: Array[Tile] # PropertyTile, PrisionTile, StartingTile, LuckOrMischanceTile
var player_nodes: Array[PlayerNode]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	round_setup()
	start_round()
	
func round_setup() -> void:
	# Vai ter que ser 0 mesmo por causa do caso em que 
	# ele eh sorteado andar 0 casas quando ele ainda esta na -1
	# TODO: adicionar a Tile inicial
	var jogador = Player.new("Jogador", 240, 0)
	
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
		var tile = PropertyTile.new(property)
		tiles.append(tile)
	
	player_nodes = board.get_players()
	for player_node in player_nodes:
		var player_core = Player.new(str("Bot %s"% player_node.name), 240, 0)
		if player_node.is_enemy:
			var controller = BotController.new(player_core, player_node)
			bot_players.append(controller)
		else:
			main_player = MainController.new(jogador, player_node, user_choice_UI)
		
	players.assign(bot_players)
	players.append(main_player)
	
	# vai servir futuramente para mover a partida para board
	board.setup(tiles, players, user_choice_UI)


func start_round() -> void:
	var rng = RandomNumberGenerator.new()
	var current_turn_index: int = 0
	
	#TODO: o player perde
	while main_player.player.get_money() < 400:
		var current_player_controller: Controller = players[current_turn_index]
		var current_player: Player = current_player_controller.player
		print("Turno de %s"% current_player.get_player_name())
		
		var initial_position: int = current_player.get_player_position()
		
		var squares = rng.randi_range(0, 4) # squares = casas
		var new_position: int = (initial_position+squares) % Board.SIZE
		# temos que usar global_position ao inves de apenas position, 
		# pois ele retornaria a posicao apenas em relacao ao pai direto dele (Que eh Tile, nao root	)
		var coordinates: Vector2 = board._tiles[new_position].marker.global_position
		
		# move para a nova casa
		current_player_controller.move_player(new_position, coordinates)
		print("Ele se moveu %d casas"%squares)
		# pra dar tempo de conferir se moveu certinho
		await get_tree().create_timer(2.0).timeout
		
		print("ele deve comecar a pensar a qualquer momento...")
		if initial_position != new_position:
			# Board -> Tile -> pergunta pra Controller:
			# Como que esse player que esta linkado a voce quer agir?
			board.activate_on_step(new_position, current_player_controller)	
		else: # nao saiu do lugar
			current_player_controller.skip_turn("nao ter se movido")
			
		await current_player_controller.turn_finished
		
		print("Turno de %s encerrado\n"% current_player.get_player_name())
		
		current_turn_index = (current_turn_index + 1) % players.size()
		print("--------------")
	print("Fim de jogo! Você ganhou")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
