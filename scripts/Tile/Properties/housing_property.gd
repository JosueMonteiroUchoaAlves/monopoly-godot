class_name HousingProperty extends Property

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var _rent: int

func _init(nameT: String, price: int, rent: int, ownerT = null):
	super(nameT, price, ownerT)
	_rent = rent

# antiga funcao activate
func charge_rent(payer: Player, receiver: Player):
	var rent: int = _rent
	payer.gain_or_spend_money(rent * -1)
	receiver.gain_or_spend_money(rent)
	print("{payer.get_name()} pagou {rent} a {receiver.get_name()}")
