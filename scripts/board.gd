class_name Board extends Node

const SIZE = 12

var _tiles: Array[Tile]
var _players: Array[Controller]

func _init(tiles: Array[Tile], players: Array[Controller]):
	_tiles = tiles
	_players = players

func display_board():
	pass

func execute_turn():
	pass
