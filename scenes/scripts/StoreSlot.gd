class_name StoreSlot extends Control

@export var mainItem: ItemData
@export var subItem: ItemData
@export var card: TextureRect
@export var inventory: Inventory
var hovering: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(mainItem)
	card.texture = mainItem._card_texture

func is_mouse_over_card() -> bool:
	var mouse_pos: Vector2 = get_global_mouse_position()
	var sprite_rect = Rect2(card.global_position, card.texture.get_size())
	return sprite_rect.has_point(mouse_pos)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_mouse_over_card():
		hovering = true
		self.scale = Vector2(1.2, 1.2)
	else:
		hovering = false
		self.scale = Vector2(1, 1)
		
func _input(event) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and hovering:
			if inventory.tokens >= mainItem._store_price:
				inventory.spend_money(mainItem._store_price)
				inventory.add_item(mainItem)
				
				self.queue_free()
