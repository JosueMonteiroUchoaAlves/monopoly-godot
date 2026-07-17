extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_start_game_pressed() -> void:
	EventBus.start_game_button_was_pressed.emit()


func _on_button_exit_pressed() -> void:
	get_tree().quit()


func _on_button_store_pressed() -> void:
	EventBus.enter_store.emit()
