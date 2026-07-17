class_name Round extends Node2D

@onready var user_choice_UI: Control = $Control
@onready var board: BoardNode = $Board

var main_player: MainController
var bot_players: Array[BotController] = []
var players: Array[Controller] = [] # Controllers
var tiles: Array[LogicTile] = [] # PropertyTile, PrisionTile, StartingTile, LuckOrMischanceTile
var titles: Array[LogicTitle] = []
var properties: Array[LogicProperty] = []
@export var inventory: Inventory
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
	
	var regular_tiles: Array[LogicTile] = []
	for i in range(16):
		var data = inventory.pick_regular_tile()
		regular_tiles.append(LogicTile.new(
			data,
			data.context_type.new()
		))
	
	var corner_tiles: Array[LogicTile] = []
	for i in range(4):
		var data = inventory.pick_corner_tile()
		corner_tiles.append(LogicTile.new(
			data,
			data.context_type.new()
		))
		
	var property_tiles: Array[LogicTile] = regular_tiles.filter(func(tile): return is_instance_of(tile.data, PropertyTileData))
	for tile in property_tiles:
		var data = inventory.pick_property()
		var logic = LogicProperty.new(
			data,
			data.context_type.new()
		)
		properties.append(logic)
		tile.context.property = weakref(logic)

	var corners = 0
	var regulars = 0
	for i in range(Board.SIZE):
		if i % 5 == 0:
			tiles.append(corner_tiles[corners])
			corners += 1
		else:
			tiles.append(regular_tiles[regulars])
			regulars += 1
	
	player_nodes = board.get_players()
	for player_node in player_nodes:
		var player_core = Player.new(str("Bot %s"% player_node.name), 200, 0)
		if player_node.is_enemy:
			var controller = BotController.new(player_core, player_node)
			bot_players.append(controller)
		else:
			main_player = MainController.new(jogador, player_node, user_choice_UI)
		
	for title in inventory.titles:
		titles.append(LogicTitle.new(
			title,
			title.context_type.new(main_player)
		))
		
	players.assign(bot_players)
	players.append(main_player)
	
	# Conecta todos os controllers ao round para que ele possa ouvir um sinal de falencia
	for controller in players:
		controller.bankruptcy.connect(on_player_bankrupt)
	
	board.setup(tiles, players, user_choice_UI)

func start_round() -> void:
	var rng = RandomNumberGenerator.new()
	var current_turn_index: int = 0
	
	var turn_context = TurnContext.new()
	
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
		
		var squares = rng.randi_range(1, 6) # squares = casas
		var new_position: int = (initial_position+squares) % Board.SIZE
		
		if initial_position != new_position:
			var intermediary_position:int = (initial_position + 1) % Board.SIZE # ja comeca indo para a proxima, claro
			var safe_global_coords: Vector2
			var coordinates: Vector2
			while (current_player.get_player_position() != new_position):
				safe_global_coords = board.get_safe_drop_coordinate(intermediary_position)
				coordinates = board.to_local(safe_global_coords)
				# move para a nova casa
				await current_player_controller.move_player(intermediary_position, coordinates)
				intermediary_position = (intermediary_position + 1) % Board.SIZE
				
		round_log("Ele se moveu %d casas"%squares)
		# pra dar tempo de conferir se moveu certinho
		await get_tree().create_timer(2.0).timeout
		
		round_log("ele deve comecar a pensar a qualquer momento...")
		if initial_position != new_position:
			# Board Node 2D -> Tile logic core -> pergunta pra Controller:
			# Como que esse player que esta linkado a voce quer agir?
			var new_tile = board.tiles[new_position].logic_core
			var land_on = LandOnContext.new(
				current_player,
				current_player_controller,
				weakref(new_tile),
				squares,
				false
			)
			print("Proximo do LandOn")
			parse_land_on_event(land_on, turn_context)
			new_tile.data.land_on(land_on, turn_context, new_tile.context)
			print("Passou do LandOn")
			
			if land_on.should_charge:
				var property = new_tile.context.property.get_ref()
				var charge_rent = RentContext.new(
					land_on.player,
					property.context._owner,
					property.data.rent,
					property.data.rent,
					land_on.controller
				)
				print("Proximo do ChargeRent")
				parse_charge_rent_event(charge_rent, turn_context)
				property.data.charge_rent(charge_rent, turn_context, property.context)
				print("Passou do ChargeRent")
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
	EventBus.round_finished.emit()
	
func on_player_bankrupt(dead_controller: Controller) -> void:
	round_log("\n[FALÊNCIA] O jogador %s quebrou e foi de arrasta pra cima!" % dead_controller.player.get_player_name())

	board.expropriation_of_assets(dead_controller.player)
				
	dead_controller.view.visible = false

func parse_land_on_event(context: LandOnContext, turnContext: TurnContext):
	for title in titles:
		title.data.on_land_on_event(context, turnContext, title.context)

	for property in properties:
		property.data.on_land_on_event(context, turnContext, property.context)

func parse_charge_rent_event(context: RentContext, turnContext: TurnContext):
	for title in titles:
		title.data.on_rent_event(context, turnContext, title.context)
	
	for property in properties:
		property.data.on_rent_event(context, turnContext, property.context)

func round_log(text: String):
	EventBus.round_log.emit(text)
