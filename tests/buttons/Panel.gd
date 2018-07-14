extends Panel

var accum = 0
var buttonpressedtimes = 0

func _ready():
	#Подсоедининие функции pressed() от кнопки Button через скрипт
	get_node("Button").connect("pressed", self, "_on_Button_pressed")
	


func _on_Button_pressed():
	get_node("Label").text = "LOL!"
	var cnt = $Label3.get_total_character_count()
	get_node("Label2").text = str(cnt - 2)
	# Можно написать также:
	# $Label2.text = str(cnt - 2)
	accum = 0
	print("lolikiiii " + str(buttonpressedtimes+1))
	
	# Удаление кнопки после пяти нажатий
	buttonpressedtimes += 1
	if buttonpressedtimes == 5:
		$Button.queue_free()
		
	
func _process(delta):
	accum += delta
	$Label3.text = str(accum)

	
	
	