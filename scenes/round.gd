extends Node2D

@onready var user_choice_UI: Control = $Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	user_choice_UI.player_choose.connect(on_player_choose)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_player_choose(choice):
	
	if choice == "buy":
		print("I think the player bought smh")
	else:
		if choice == "pass":
			print("Bro was too afraid to gamble")
		else:
			# Hacker choice?
			print("Tf is this guy doing??")
			
	
