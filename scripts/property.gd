@abstract
class_name Property extends Resource

var _owner: Player : get=get_property_owner, set=buy_property
var _price: int :  get=get_property_price
var _name: String : get=get_property_name

func _init(name: String, price: int, owner: Player = null):
	_name = name
	_price = price
	_owner = owner

# antiga funcao "activate"
#TODO o payer ser um controller permite em algum momento o player
# poder vender alguma property ou Asset para a board (ou player) para sair da divida
@abstract
func charge_rent(payer: Controller)

func get_property_name():
	return _name
	
func get_property_price():
	return _price
	
func get_property_owner():
	return _owner
	
# por enquanto so poderam comprar propriedades. Nada de trocas por agora...
func buy_property(player: Player):
	# pra parar de disparar um erro ao definir o setter
	if player:
		if player.get_money() >= self._price:	
			_owner = player
			player.gain_or_spend_money(self._price * -1)
		else:
			print("Querer nao eh poder...")
