#@tool
class_name TileNode extends Node2D

#@export var textura_personalizada: Texture2D
@onready var sprite: Sprite2D = $Sprite

@onready var marker : Marker2D = $Marker
@export var is_corner: bool
var logic_core: Tile

# DESCOMENTAR AS LINHAS SE NECESSARIO VISUALIZAR TEXTURA SEM RODAR O CODIGO

func _ready():
	#if textura_personalizada:
		#sprite.texture = textura_personalizada
	pass
func definir_textura(nova_textura: Texture2D):
	sprite.texture = nova_textura
	
#-- These are not being used in this iteration at the moment.
#@export var price: float
#@export var tile_name: String
#var property: Property
#var logic_core: HousingPropertie = HousingPropertie.new("O Escritorio (do ingles The Office)", 100, 10)
#--
