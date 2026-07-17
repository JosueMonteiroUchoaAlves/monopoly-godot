@abstract class_name ItemData extends Resource

enum ItemType {
	exploration,
	people,
	arts,
	industry,
	neutral
} 

@export var _name: String 
@export var _description: String
@export var _store_price: int
@export var _card_texture: Texture2D
@export var _needs_sub: bool = false
@export var context_type: GDScript
@export var type: ItemType = ItemType.neutral

func check_context_format(context: Context):
	assert(is_instance_of(context, context_type), "Wrong context type on %s" % _name)
