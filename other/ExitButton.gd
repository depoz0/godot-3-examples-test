extends Node2D

func _ready():
	get_node("Menu").connect("pressed", self, "_on_Menu_pressed")
	get_node("Pause").connect("pressed", self, "_on_Pause_pressed")
	
	if get_tree().paused == true:
		$Paused.show()
	if get_tree().paused == false:
		$Paused.hide()



func _on_Menu_pressed():
	save_game()
	get_tree().change_scene("res://tests/buttons/Menu.tscn")
	#get_tree().quit()
	

func _on_Pause_pressed():
	if get_tree().paused == true:
		get_tree().paused = false
		$Paused.hide()
	elif get_tree().paused == false:
		get_tree().paused = true
		$Paused.show()
		
func save_game():
	var save_game = File.new()
	save_game.open("res://savegame.save", File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("gamesave")
	
	for i in save_nodes:
		var node_data = i.call("save");
		save_game.store_line(to_json(node_data))
 	save_game.close()

	
func load_game():
	pass