class_name Inventory extends Resource

@export var tiles: Array[GenericTileData] = []
@export var titles: Array[TitleData] = []
@export var properties: Array[PropertyData] = []
@export var tokens: int = 3

func pick_regular_tile() -> GenericTileData:
	var regular_tiles = tiles.filter(func(tile): return not tile.is_corner)
	return regular_tiles.pick_random()
	
func pick_corner_tile() -> GenericTileData:
	var corner_tiles = tiles.filter(func(tile): return tile.is_corner)
	return corner_tiles.pick_random()
	
func pick_title() -> TitleData:
	return titles.pick_random()
	
func pick_property() -> PropertyData:
	return properties.pick_random()
	
func spend_money(value: int) -> int:
	tokens -= value
	if tokens == 0:
		tokens = 0
	
	return tokens
	
func add_item(item: ItemData) -> bool:
	if item is GenericTileData:
		tiles.append(item)
		return true
	elif item is TitleData:
		titles.append(item)
		return true
	elif item is PropertyData:
		properties.append(item)
		return true
		
	return false

func contains_item(item: ItemData) -> bool:
	if item is GenericTileData:
		return item in tiles
	elif item is TitleData:
		return item in titles
	elif item is PropertyData:
		return item in properties
	
	return false
