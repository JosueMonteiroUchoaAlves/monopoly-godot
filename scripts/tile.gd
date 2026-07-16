@abstract
class_name Tile extends Resource

@export var _property: Property

func _init(property: Property = null):
	_property = property
	
# Faz sentido que ele receba um Controller porque ele tem acesso tanto
# ao pagamento do player quanto ao metodo que pede pro player escolher
@abstract
func land_on(player: Controller)
