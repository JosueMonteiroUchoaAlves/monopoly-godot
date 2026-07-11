class_name Player extends Node

var BOARD_SIZE: int = Board.SIZE

@export var _money: int :  get=get_money
@export var _position: int : get=get_position
@export var _name: String : get=get_player_name

func _init(name: String, money: int, position: int):
	_money = money
	_position = position
	_name = name

func gain_or_spend_money( money: int):
	_money += money

func move( tile_quantity: int):
	_position = (_position + tile_quantity) % BOARD_SIZE

func get_position():
	return _position

func get_player_name():
	return _name

func get_money():
	return _money
