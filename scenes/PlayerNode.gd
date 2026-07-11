class_name PlayerNode extends Node2D

@onready var sprite: Sprite2D = $Sprite
@export var sprite_player: Texture2D
@export var sprite_enemy: Texture2D
@export var is_enemy: bool = false

var logic_core: Player = Player.new("Josue", 100, -1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if is_enemy:
		sprite.texture = sprite_enemy
	else:
		sprite.texture = sprite_player

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
