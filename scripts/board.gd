class_name Board extends Node

const SIZE = 9

@export var _tiles: Array[Tile]
@export var _players: Array[Controller]

func _init(tiles: Array[Tile], players: Array[Controller]):
	_tiles = tiles
	_players = players

func display_board():
	pass

func execute_turn():
	for controller: Controller in _players:
		var position: int = controller.player.get_position()
		controller.play.activate_controller()
		var new_position: int = controller.player.get_position()
		if position != new_position:
			_tiles[new_position].activate(controller.player)		
