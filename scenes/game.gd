extends Node
var main_scene: Node
var overlay_scene: Node

func change_scene(
	new_scene: String, 
	delete: bool = false
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
	var store = $Store
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
