class_name Board extends Node

const SIZE = 20

var _tiles: Array[LogicTile]
var _players: Array[Controller]

func _init(tiles: Array[LogicTile], players: Array[Controller]):
	_tiles = tiles
	_players = players
	
func execute_turn():
	pass
	
