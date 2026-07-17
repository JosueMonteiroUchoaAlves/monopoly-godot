extends PanelContainer

func _ready() -> void:
	var style = StyleBoxFlat.new()
	
	style.bg_color = Color("#28372B") # Verde Feltro
	style.border_color = Color("#8C7335") # Ouro Vegas
	style.border_width_bottom = 6
	style.set_corner_radius_all(8) # Arredondamento
	
	# O PanelContainer usa a chave "panel", não "normal"
	add_theme_stylebox_override("panel", style)
