extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"



func _ready():
	#get_node("LoadSettings").get_script()
	#get_node("LoadSettings").load_data()
	if $LoadSettings.showfps == "true":
		$MarginContainer/VBoxContainer/CheckBox.pressed = true
		
	get_node("MarginContainer/VBoxContainer/Button").connect("pressed", self, "_on_Button_pressed")
	get_node("MarginContainer/VBoxContainer/Button2").connect("pressed", self, "_on_Button2_pressed")
	get_node("MarginContainer/VBoxContainer/CheckBox").connect("toggled", self, "_on_CheckBox_toggled")
	# Called when the node is added to the scene for the first time.
	# Initialization here
	#pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_Button_pressed():
	save_data()

func _on_Button2_pressed():
	get_tree().change_scene("res://tests/buttons/Menu.tscn")

func getdata():
	var _user_data = { "showfps": $LoadSettings.showfps,
					"tets": "lolikkk"
					}
	return _user_data
	
func save_data():
	
    var f = File.new()
    f.open("user://configGOdot.cfg",File.WRITE)
    f.store_string(to_json(getdata()))
    f.close()


func _on_CheckBox_toggled(button_pressed):
	if button_pressed == true:
		$LoadSettings.showfps = "true"
	else:
		$LoadSettings.showfps = "false"
	save_data()


