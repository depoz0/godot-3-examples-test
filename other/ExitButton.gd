extends Node2D

func _ready():
	get_node("Menu").connect("pressed", self, "_on_Menu_pressed")
	get_node("Pause").connect("pressed", self, "_on_Pause_pressed")
	
	if get_tree().paused == true:
		$Paused.show()
	if get_tree().paused == false:
		$Paused.hide()



func _on_Menu_pressed():
	get_tree().change_scene("res://tests/buttons/Menu.tscn")
	#get_tree().quit()

func _on_Pause_pressed():
	if get_tree().paused == true:
		get_tree().paused = false
		$Paused.hide()
	elif get_tree().paused == false:
		get_tree().paused = true
		$Paused.show()
	