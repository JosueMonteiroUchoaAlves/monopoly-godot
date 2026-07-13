@abstract
class_name Controller extends Node

var player: Player
var view: PlayerNode

signal turn_finished

func _init(player_t: Player, view_t: PlayerNode) -> void:
	player = player_t
	view = view_t

@abstract
func execute_turn()

# Called when the node enters the scene tree for the first time.
# func _ready() -> void:
# 	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta: float) -> void:
# 	pass
