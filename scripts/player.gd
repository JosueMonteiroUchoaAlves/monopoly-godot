class_name Player extends Node

var BOARD_SIZE: int = Board.SIZE

@export var _money: int :  get=get_money
@export var _position: int : get=get_player_position, set=set_player_position
@export var _name: String : get=get_player_name
var n_actions: int

func _init(name_t: String, money: int, position_t: int):
	_money = money
	_position = position_t
	_name = name_t

func gain_or_spend_money(money: int):
	_money += money

func move(new_position: int):
	_position = new_position

func get_player_position() -> int:
	return _position
	
func set_player_position(new_position: int):
	_position = new_position

func get_player_name():
	return _name

func get_money():
	return _money
