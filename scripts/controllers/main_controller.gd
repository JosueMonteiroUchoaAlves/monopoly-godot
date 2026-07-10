class_name MainController extends Controller

@export var titles: Array[Title] = []
@export var properties: Array[Property] = []
@export var Tiles: Array[Tile] = []
@export var skips: int = 3
@export var plays: int = 4

signal end_skips
signal end_plays

var rng = RandomNumberGenerator.new()

func executeTurn(will_skip: bool):
	if not will_skip:
		var value = rng.randi_range(0, 5)
		player.move(value)
		
		plays -= 1
		if plays == 0:
			end_plays.emit()
	else:
		skips -= 1
		if skips == 0:
			end_skips.emit()
