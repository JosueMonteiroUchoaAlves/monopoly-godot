@abstract
class_name Property extends Node

var _owner: Player : get=get_property_owner, set=buy_property
var _name: String : get=get_property_name
@export var _base_data: PropertyData = PropertyData.new()

func get_property_owner():
	return _owner

func _init(name: String, price: int, owner: Player = null):
	_base_data._price = price
	_name = name
	_owner = owner
	
func set_property_owner(player: Player):
	_owner = player

# antiga funcao "activate"
#TODO o payer ser um controller permite em algum momento o player
# poder vender alguma property ou Asset para a board (ou player) para sair da divida
@abstract
func charge_rent(payer: Controller)

func get_property_name():
	return _name
	
func get_property_price():
	return _base_data._price
	
# por enquanto so poderam comprar propriedades. Nada de trocas por agora...
func buy_property(player: Player):
	# pra parar de disparar um erro ao definir o setter
	if player:
		if player.get_money() >= self._price:	
			_owner = player
			player.gain_or_spend_money(self._price * -1)
		else:
			print("Querer nao eh poder...")
