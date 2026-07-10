extends Node2D

@onready var personagem: Sprite2D = $PersonagemSprite
@onready var positions: Array[Marker2D] = [$TileTesteMarker2D1, $TileTesteMarker2D2,$TileTesteMarker2D3]

var nActions:int = -1

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_click"):
		nActions = (nActions + 1) % 3
		
		# A funcao tween faz transicao suave entre posicoes
		var tween = create_tween()
		tween.tween_property(personagem,"position", positions[nActions].position, 0.3)

func _ready() -> void:
	print("Debug Logs")
