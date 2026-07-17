extends Control

func _on_next_round_pressed() -> void:
	EventBus.start_game_button_was_pressed.emit() # Cria um round novo e limpo
	queue_free() # Apaga a si mesmo da memória
func _on_store_pressed() -> void:
	EventBus.enter_store.emit()
	queue_free()
func _on_main_menu_pressed() -> void:
	EventBus.main_menu_button_was_pressed.emit()
	queue_free()
