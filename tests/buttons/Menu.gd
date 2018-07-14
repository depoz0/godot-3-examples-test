extends MarginContainer






var buttonpressedtimes = 0

func _ready():
	if get_tree().paused == true: #снятие с паузы
		get_tree().paused = false
	if $LoadSettings.showfps == "true":
		$LoadSettings/FPS.show()
	else:
		$LoadSettings/FPS.hide()
		
		
	
		
	
		
	#Подсоедининие функции pressed() от кнопки Button через скрипт
	get_node("VBoxContainer/Button").connect("pressed", self, "_on_Button_pressed")
	get_node("VBoxContainer/Button2").connect("pressed", self, "_on_Button2_pressed")
	get_node("VBoxContainer/Button3").connect("pressed", self, "_on_Button3_pressed")
	get_node("VBoxContainer/Button4").connect("pressed", self, "_on_Button4_pressed")
	#print(get_node("/root"))
	#Engine.set_window_size(Vector2(540, 960))
	
	



func _on_Button_pressed():
	$Banner.loadBAN("loadbig") # Загрузка баннера
	#get_node("VBoxContainer/Label").text = str(get_node("/root")) # размер/зрешение viewport
	#var cnt = $VBoxContainer/Label3.get_total_character_count()
	#get_node("VBoxContainer/Label2").text = str(cnt - 2)
	# Можно написать также:
	# $Label2.text = str(cnt - 2)
	print("lolikiiii " + str(buttonpressedtimes+1))
	
	
	
	# Удаление кнопки после пяти нажатий
	buttonpressedtimes += 1
	if buttonpressedtimes == 5:
		$VBoxContainer/Button.queue_free()
		
	
	
func _on_Button2_pressed():
	get_tree().quit()
	
func _on_Button3_pressed():
	get_tree().change_scene("res://maps/TestMap.tscn")

func _on_Button4_pressed():
	get_tree().change_scene("res://tests/buttons/Settings.tscn")

func _process(delta):

	$VBoxContainer/Label4.text = "FPS: " + fps()
	$VBoxContainer/Label5.text = str(get_viewport().get_visible_rect().size)
	
	
func fps():			# FPS
	var det = str(Engine.get_frames_per_second())
	return det
	