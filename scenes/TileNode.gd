class_name TileNode extends Node2D

@onready var marker : Marker2D = $Marker
@export var price: float
@export var tile_name: String

var property: Property
var logic_core: HousingPropertie = HousingPropertie.new("O Escritorio (do ingles The Office)", 100, 10)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
