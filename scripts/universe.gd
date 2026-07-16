class_name Universe extends Resource

enum ItemType {
	Tile,
	Title,
	Property
}

@export var tiles: Array[GenericTileData]
@export var titles: Array[TitleData]
@export var properties: Array[PropertyData]

func get_item_by_type(type: ItemType):
	match type:
		ItemType.Tile:
			return tiles.pick_random()
		ItemType.Title:
			return titles.pick_random()
		ItemType.Property:
			return properties.pick_random()
