class_name Game extends Node

var main_scene: Node = null
var overlay_scene: Node

func change_scene(
	new_scene: String, 
	delete: bool = true
) -> void:
	if main_scene != null:
		if delete:
			main_scene.queue_free()
		else:
			self.remove_child(main_scene)
	var new = load(new_scene).instantiate()
	self.add_child(new)
	main_scene = new

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.start_game_button_was_pressed.connect(_on_start_game_button_was_pressed)
	EventBus.main_menu_button_was_pressed.connect(_on_main_menu_button_was_pressed)
	EventBus.round_finished.connect(_on_round_finished)
	EventBus.enter_store.connect(_on_enter_store)
	EventBus.close_overlay.connect(_on_close_overlay)
	
	change_scene("res://scenes/MainMenu.tscn")
	
func _on_start_game_button_was_pressed():
	change_scene("res://scenes/Round.tscn")

func _on_main_menu_button_was_pressed():
	change_scene("res://scenes/MainMenu.tscn")

func _on_enter_store():
	change_scene("res://scenes/Store.tscn")

func _on_round_finished():
	var stats = load("res://scenes/EndRoundStats.tscn").instantiate()
	add_child(stats)
		
func _on_close_overlay(overlay_node: Node):
	if is_instance_valid(overlay_node):
		overlay_node.queue_free()
