extends Button

var style: StyleBoxFlat
var base_border: int = 6 # Altura da sua borda inferior
var default_y: float
var is_pressing: bool = false
var fonte = preload("res://sprites/UI/GrapeSoda.ttf") 
var hover_sound := AudioStreamPlayer.new()
var click_sound := AudioStreamPlayer.new()

func _ready() -> void:
	style = get_theme_stylebox("normal").duplicate()
	add_theme_stylebox_override("normal", style)
	add_theme_stylebox_override("hover", style)
	add_theme_stylebox_override("pressed", style)
	add_theme_font_override("font", fonte)

	hover_sound.stream = preload("res://audio/hover_glass_005.ogg")
	hover_sound.volume_db = -20.0
	click_sound.stream = preload("res://audio/click_drop_003.ogg")
	click_sound.volume_db = -4.0
	# Evita que o som da UI seja afetado pela posição da câmera (AudioStreamPlayer comum, não 2D)
	add_child(hover_sound)
	add_child(click_sound)
	
	# Nova Paleta Base Aplicada
	style.bg_color = Color("#2A4B3C") # Verde Feltro (Fundo)
	style.border_color = Color("#C5B358") # Ouro Vegas (Borda inferior)
	style.border_width_bottom = base_border
	
	# Força a cor do texto para manter a legibilidade
	add_theme_color_override("font_color", Color("#F3EFE0")) # Papel Moeda
	
	pivot_offset = size / 2
	default_y = position.y
	
	mouse_entered.connect(_on_hover)
	mouse_exited.connect(_on_exit)
	button_down.connect(_on_press)
	button_up.connect(_on_release)

func _on_hover() -> void:
	if is_pressing: return
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "rotation_degrees", randf_range(-2.5, 2.5), 0.1).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	# Borda acende para um amarelo mais brilhante/ativo no hover
	tween.tween_property(style, "border_color", Color("#F3EFE0"), 0.1) 
	# Variação de pitch evita fadiga auditiva (o efeito metralhadora)
	hover_sound.pitch_scale = randf_range(0.9, 1.1)
	hover_sound.play()
	
func _on_exit() -> void:
	if is_pressing: return
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "rotation_degrees", 0.0, 0.15).set_trans(Tween.TRANS_SINE)
	# Retorna ao Ouro Vegas base
	tween.tween_property(style, "border_color", Color("#C5B358"), 0.15)

func _on_press() -> void:
	is_pressing = true
	var tween = create_tween().set_parallel(true)
	
	# Desfaz a rotação brutalmente
	tween.tween_property(self, "rotation_degrees", 0.0, 0.05).set_trans(Tween.TRANS_CUBIC)
	
	# "Come" a borda e joga o corpo do botão para baixo simulando a física
	tween.tween_property(style, "border_width_bottom", 0, 0.05)
	tween.tween_property(self, "position:y", default_y + base_border, 0.05)
	click_sound.pitch_scale = randf_range(0.95, 1.05) # Variação menor no clique para manter o peso
	click_sound.play()
	
func _on_release() -> void:
	var tween = create_tween().set_parallel(true)
	
	# Estoura a borda de volta para cima
	tween.tween_property(style, "border_width_bottom", base_border, 0.15).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position:y", default_y, 0.15).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
	await tween.finished
	is_pressing = false
	
	# Reavalia se o mouse continua no botão
	if is_hovered():
		_on_hover()
