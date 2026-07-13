class_name MainController extends Controller

var titles: Array[Title] = []
var properties: Array[Property] = []
var skips: int = 3
var plays: int = 4
var Tiles: Array[Tile] = []

signal end_skips
signal end_plays

var rng = RandomNumberGenerator.new()

func execute_turn():
	print("\nJogador esta jogando...")
	
	await Engine.get_main_loop().create_timer(2.0).timeout
	
	turn_finished.emit()
