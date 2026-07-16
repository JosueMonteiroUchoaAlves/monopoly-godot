extends Control

# pode ser um enum dps
signal player_choose(choice:String)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_buy_button_up() -> void:
	player_choose.emit("buy")

func _on_pass_button_up() -> void:
	player_choose.emit("pass")
