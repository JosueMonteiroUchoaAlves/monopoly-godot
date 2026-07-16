extends Control

@export var STORE_SLOTS = 2
@export var inventory: Inventory
@export var universe: Universe
@export var probability_dist: Dictionary[Universe.ItemType, float] = {
	Universe.ItemType.Title: 0.4,
	Universe.ItemType.Tile: 0.3,
	Universe.ItemType.Property: 0.3,
}
@export var store_slot: PackedScene
@export var container: HBoxContainer

var rng = RandomNumberGenerator.new()

func rand_select_store_item() -> ItemData:
	var weight_sum: float = 0.0
	for key in probability_dist.keys():
		weight_sum += probability_dist[key]
	
	var value = rng.randf() * weight_sum
	var item: ItemData = null
	for key in probability_dist.keys():
		if value < probability_dist[key]:
			item = universe.get_item_by_type(key)
			break
		value -= probability_dist[key]
	
	if not item:
		item = universe.get_item_by_type(Universe.ItemType.Title)
	
	if inventory.contains_item(item):
		return rand_select_store_item()
	else:
		return item

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(STORE_SLOTS):
		var slot_instance = store_slot.instantiate()
		slot_instance.mainItem = rand_select_store_item()
		slot_instance.inventory = inventory
		container.add_child(slot_instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
