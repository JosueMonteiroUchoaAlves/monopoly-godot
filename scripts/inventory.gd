class_name Inventory extends Resource

@export var tiles: Array[GenericTileData] = []
@export var titles: Array[TitleData] = []
@export var properties: Array[PropertyData] = []
@export var tokens: int = 3

# "Baralhos" temporários que vamos usar para não repetir os itens
var _available_properties: Array[PropertyData] = []
var _available_titles: Array[TitleData] = []

# Chame essa função quando for criar um novo tabuleiro para embaralhar as cartas novamente
func reset_pools() -> void:
	_available_properties = properties.duplicate()
	_available_properties.shuffle()
	
	_available_titles = titles.duplicate()
	_available_titles.shuffle()

func pick_regular_tile() -> GenericTileData:
	var regular_tiles = tiles.filter(func(tile): return not tile.is_corner)
	return regular_tiles.pick_random()
	
func pick_corner_tile() -> GenericTileData:
	var corner_tiles = tiles.filter(func(tile): return tile.is_corner)
	return corner_tiles.pick_random()

func pick_title() -> TitleData:
	if _available_titles.is_empty():
		push_warning("Aviso: Tentou pegar um Título, mas eles acabaram!")
		return null
		
	# pop_back() pega o último item da lista e o remove dela
	return _available_titles.pop_back()
	
func pick_property() -> PropertyData:
	if _available_properties.is_empty():
		push_warning("Aviso: Tentou pegar uma Propriedade, mas elas acabaram!")
		return null
		
	# Pega uma propriedade sem repetir e já remove das disponíveis
	return _available_properties.pop_back()
	
func spend_money(value: int) -> int:
	tokens -= value
	if tokens < 0: # Corrigi aqui para evitar que tokens fiquem negativos caso passe do valor
		tokens = 0
	return tokens
	
func add_item(item: ItemData) -> bool:
	if item is GenericTileData:
		if not item in tiles:
			tiles.append(item)
			return true
	elif item is TitleData:
		if not item in titles:
			titles.append(item)
			_available_titles.append(item) # Adiciona ao baralho atual
			return true
	elif item is PropertyData:
		if not item in properties:
			properties.append(item)
			_available_properties.append(item) # Adiciona ao baralho atual
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
