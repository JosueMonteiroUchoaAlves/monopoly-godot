class_name StoreSlot extends Control

@export var mainItem: ItemData
@export var subItem: ItemData
@export var card: TextureRect
@export var inventory: Inventory

@onready var base_card = $BaseCard

var is_hovering: bool = false

func _ready() -> void:
	card.texture = mainItem._card_texture
	base_card.pivot_offset = Vector2(60, 80)
	
	mouse_entered.connect(_on_hover)
	mouse_exited.connect(_on_exit)

func _on_hover() -> void:
	is_hovering = true 
	z_index = 1 
	var tween = create_tween().set_parallel(true)
	tween.tween_property(base_card, "scale", Vector2(1.15, 1.05), 0.1).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(base_card, "rotation_degrees", randf_range(-3.0, 3.0), 0.1).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

func _on_exit() -> void:
	is_hovering = false 
	z_index = 0
	var tween = create_tween().set_parallel(true)
	tween.tween_property(base_card, "scale", Vector2(1.0, 1.0), 0.15).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(base_card, "rotation_degrees", 0.0, 0.15).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		
func _input(event) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and is_hovering: 
			if inventory.tokens >= mainItem._store_price:
				inventory.spend_money(mainItem._store_price)
				inventory.add_item(mainItem)
				self.queue_free()
