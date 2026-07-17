class_name Round extends Node2D

@onready var user_choice_UI: Control = $Control
@onready var board: BoardNode = $Board

var main_player: MainController
var bot_players: Array[BotController] = []
var players: Array[Controller] = [] # Controllers
var tiles: Array[Tile] # PropertyTile, PrisionTile, StartingTile, LuckOrMischanceTile
var player_nodes: Array[PlayerNode]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	round_setup()
	# nao esta funcionando no momento:
	start_round()
	
func round_setup() -> void:
	# Vai ter que ser 0 mesmo por causa do caso em que 
	# ele eh sorteado andar 0 casas quando ele ainda esta na -1
	# TODO: adicionar a Tile inicial
	var jogador = Player.new("Jogador", 200, 0)
	
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
		"Bomba de Etanol",
		"Rua das laranjeiras",
		"Rua dos limoes",
		"Rua dos macacos",
		"Rua dos quiabos",
	]
	
	# 4 porque sao as quinas, que nunca vao ser housing property
	for i in range(Board.SIZE-4):
		var property = HousingProperty.new(properties[i], 60, 60)
		var tile = PropertyTile.new(property)
		tiles.append(tile)
	
	player_nodes = board.get_players()
	for player_node in player_nodes:
		var player_core = Player.new(str("Bot %s"% player_node.name), 200, 0)
		if player_node.is_enemy:
			var controller = BotController.new(player_core, player_node)
			bot_players.append(controller)
		else:
			main_player = MainController.new(jogador, player_node, user_choice_UI)
		
	players.assign(bot_players)
	players.append(main_player)
	
	# Conecta todos os controllers ao round para que ele possa ouvir um sinal de falencia
	for controller in players:
		controller.bankruptcy.connect(on_player_bankrupt)
	
	board.setup(tiles, players, user_choice_UI)

func start_round() -> void:
	var rng = RandomNumberGenerator.new()
	var current_turn_index: int = 0
	
	while main_player.player.get_money() >= 0 && main_player.player.get_money() < 1000 && players.size() > 1:
		var current_player_controller: Controller = players[current_turn_index]
		var current_player: Player = current_player_controller.player
		if current_player_controller.is_bankrupt: 
			players.remove_at(current_turn_index)
			current_player_controller.view.queue_free()
			current_player_controller.queue_free()
			current_turn_index = current_turn_index % players.size()
			continue
			
		round_log("Turno de %s"% current_player.get_player_name())
		
		var initial_position: int = current_player.get_player_position()
		
		var squares = rng.randi_range(0, 4) # squares = casas
		var new_position: int = (initial_position+squares) % Board.SIZE
		
		if initial_position != new_position:
			var intermediary_position:int = initial_position+1 # ja comeca indo para a proxima, claro
			var safe_global_coords: Vector2
			var coordinates: Vector2
			while (current_player.get_player_position() != new_position):
				safe_global_coords = board.get_safe_drop_coordinate(intermediary_position)
				coordinates = board.to_local(safe_global_coords)
				# move para a nova casa
				await current_player_controller.move_player(intermediary_position, coordinates)
				intermediary_position += 1
				
		round_log("Ele se moveu %d casas"%squares)
		# pra dar tempo de conferir se moveu certinho
		await get_tree().create_timer(2.0).timeout
		
		round_log("ele deve comecar a pensar a qualquer momento...")
		if initial_position != new_position && false: ## tirar o false para poder jogar
			# Board Node 2D -> Tile logic core -> pergunta pra Controller:
			# Como que esse player que esta linkado a voce quer agir?
			board.execute_turn(new_position, current_player_controller)
		else: # nao saiu do lugar
			current_player_controller.skip_turn("nao ter se movido")
			
		await current_player_controller.turn_finished
		
		round_log("Turno de %s encerrado\n"% current_player.get_player_name())
		
		current_turn_index = (current_turn_index + 1) % players.size()
		round_log("--------------")
		
		var active_players = players.filter(func(p): return not p.is_bankrupt)
		if active_players.size() <= 1:
			break
			
	#- 1. O Jogador faliu
	if main_player.is_bankrupt:
		round_log("\nFim de jogo para você! SLK sabe jogar nn? Tu perdeu caba kkkk")
	#-- 2. O Jogador atingiu a meta de dinheiro
	elif main_player.player.get_money() >= 1000:
		round_log("\nFim de jogo! Você bateu a meta e ficou milionário com %d na conta!" % main_player.player.get_money())
	#--- 3. Restou apenas um sobrevivente (eliminação total)
	else:
		var vivos = players.filter(func(p): return not p.is_bankrupt)
		if vivos.size() == 1:
			var vencedor: Controller = vivos[0]
			if vencedor is MainController:
				round_log("\nFim de jogo! Todos os bots faliram e você venceu a partida!")
			else:
				round_log("\nO %s amassou todo mundo e venceu!" % vencedor.player.get_player_name())
	
func on_player_bankrupt(dead_controller: Controller) -> void:
	round_log("\n[FALÊNCIA] O jogador %s quebrou e foi de arrasta pra cima!" % dead_controller.player.get_player_name())

	board.expropriation_of_assets(dead_controller.player)
				
	dead_controller.view.visible = false

func round_log(text: String):
	EventBus.round_log.emit(text)
