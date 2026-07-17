@abstract
class_name Controller extends Node

var player: Player
var view: PlayerNode
var is_bankrupt: bool = false

signal turn_finished
signal bankruptcy(controller: Controller)

func _init(player_t: Player, view_t: PlayerNode) -> void:
	player = player_t
	view = view_t
	
func move_player(new_position: int, coordinates: Vector2) -> void:
	#-- Logicamente
	player.move(new_position)
	#-- Visualmente
	await view.move(coordinates)


func file_for_bankruptcy():
	is_bankrupt = true
	print("%s faliu"%player.get_player_name())
	bankruptcy.emit(self)

func skip_turn(reason: String) -> void:
	print("%s teve seu turno eskipado por %s\n"%[player._name, reason])
	await Engine.get_main_loop().create_timer(1.0).timeout
	turn_finished.emit()
