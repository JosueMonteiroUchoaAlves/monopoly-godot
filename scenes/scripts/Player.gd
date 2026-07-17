class_name PlayerNode extends Node2D

@onready var sprite: Sprite2D = $Sprite
@export var sprite_player: Texture2D
@export var sprite_enemy: Texture2D
@export var is_enemy: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if is_enemy:
		sprite.texture = sprite_enemy
	else:
		sprite.texture = sprite_player

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func move(destination: Vector2):	
	# A funcao tween faz transicao suave entre posicoes
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CIRC)
	tween.set_ease(Tween.EASE_OUT)
		
	# temos que usar global_position ao inves de apenas position, 
	# pois ele retornaria a posicao apenas em relacao ao pai direto dele (Que eh Tile, nao root	)
	tween.tween_property(self,"position", destination, 0.5)
	await tween.finished
