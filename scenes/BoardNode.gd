class_name BoardNode extends Node2D

@onready var personagem: Node2D = $Player
@onready var inimigo: Node2D = $Player
@onready var Tiles: Array[TileNode] = [$Tile1,$Tile2,$Tile3]

#var board: Board = Board.new()
var nActions:int = -1

func _ready() -> void:
	print("Debug Logs - Board")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#while (main_player.get_money() <= 400) or not main_player.get_controller().get_resources():
	#	execute_turn()
	
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_click"):
		nActions = (nActions + 1) % 3

		# A funcao tween faz transicao suave entre posicoes
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_CIRC)
		tween.set_ease(Tween.EASE_OUT)
		
		# temos que usar global_position ao inves de apenas position, 
		# pois ele retornaria a posicao apenas em relacao ao pai direto dele (Que eh Tile, nao root	)
		var destino: Vector2 = Tiles[nActions].marker.global_position
		tween.tween_property(personagem,"position", destino, 0.3)
