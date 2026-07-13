class_name BotController extends Controller


var rng = RandomNumberGenerator.new()

func execute_turn():
	print("\nBot esta jogando...")
	
	# precisa de um await para a funcao que chamou ela assumir o 
	# controle denovo e esperar o sinal
	await Engine.get_main_loop().create_timer(2.0).timeout
	turn_finished.emit()
