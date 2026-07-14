class_name BotController extends Controller

# The chance of buying a property -> the default is 3
var aggressiveness: int = 3

var rng = RandomNumberGenerator.new()
func execute_turn(_property: Property):
	print("%s esta pensando..."%player._name)
	
	var random_choice = rng.randi_range(1,10)
	if random_choice <= aggressiveness:
		print("%s resolveu comprar a propriedade"%player._name)
		_property.buy_property(player)
		print("agora ele tem %d no bolso"%player.get_money())
	else: 
		print("%s nao quis a propriedade"%player._name)
	# precisa de um await para a funcao que chamou ela assumir o 
	# controle denovo e esperar o sinal
	await Engine.get_main_loop().create_timer(2.0).timeout
	turn_finished.emit()
