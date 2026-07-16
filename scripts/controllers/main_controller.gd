class_name MainController extends Controller

var _UIcontrol: Control
var titles: Array[Title] = []
var properties: Array[Property] = []
var skips: int = 3
var plays: int = 4
var Tiles: Array[Tile] = []

signal end_skips
signal end_plays

func _init(player_t: Player, view_t: PlayerNode, UIcontrol:Control):
	super(player_t, view_t)
	_UIcontrol = UIcontrol

var rng = RandomNumberGenerator.new()

func execute_turn(_property: Property):
	print("%s esta pensando..."%player._name)
	
	var choice: String = await _UIcontrol.player_choose
	if choice == "buy":
		print("%s resolveu comprar a propriedade"%player._name)
		_property.buy_property(player)
		print("agora ele tem %d no bolso"%player.get_money())
	else:
		if choice == "pass":
			print("Bro was too afraid to gamble")
			print("%s nao quis a propriedade"%player._name)
		else:
			# Hacker choice?
			print("Tf is this guy doing??")
	await Engine.get_main_loop().create_timer(1.0).timeout
	turn_finished.emit()
