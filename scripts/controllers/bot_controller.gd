class_name BotController extends Controller

# The chance of buying a property -> the default is 3
var aggressiveness: int = 3 # maximo eh 10 - caio mude pra variavel

var rng = RandomNumberGenerator.new()
func execute_turn(_property: LogicProperty):
	round_log("%s esta pensando..."%player._name)
	
	var random_choice = rng.randi_range(1,10)
	if random_choice <= aggressiveness:
		round_log("%s resolveu comprar a propriedade"%player._name)
		var buy_property = BuyPropertyContext.new(
			player,
			weakref(_property),
			_property.data._price
		)
		# TurnContext.new() é uma gambiarra. Idealmente, essa informação seria do Round
		_property.data.buy_property(buy_property, TurnContext.new(), _property.context)
		round_log("agora ele tem %d no bolso"%player.get_money())
	else: 
		round_log("%s nao quis a propriedade"%player._name)
	# precisa de um await para a funcao que chamou ela assumir o 
	# controle denovo e esperar o sinal
	await Engine.get_main_loop().create_timer(0.1).timeout # depois vai ser um tempo aleatorio - caio
	turn_finished.emit()

func round_log(text: String):
	EventBus.round_log.emit(text)
