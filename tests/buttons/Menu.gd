extends MarginContainer


var is_android = false # if exporting to Android change to "true"


var buttonpressedtimes = 0 # temp

func _ready():
	if resume_game("scene") == null:
		$VBoxContainer/Button3.hide()
	else:
		$VBoxContainer/Button3.show()
		
	if get_tree().paused == true: #снятие с паузы
		get_tree().paused = false
	if $LoadSettings.showfps == "true":
		$LoadSettings/FPS.show()
	else:
		$LoadSettings/FPS.hide()
	if $LoadSettings.todo == "true":
		$VBoxContainer/TextEdit.show()
	else:
		$VBoxContainer/TextEdit.hide()
		
	if is_android == true:
		$VBoxContainer/version.hide()
		
# Auto Versioning (testing / not working on Android)
	if is_android == false:
		var notes = File.new()
		#var dd = notes.get_md5("res://default_env.tres")
		var dd = notes.get_modified_time("res://default_env.tres")
		var version = loadfile("res://version", 1)
		var verhash
		var verver
		var build
		var build2
		var build3
		print (version)
		if version["ver"] != null:
			for i in version.keys():
				if i == "hash":
					verhash = version[i]
				if i == "ver":
					verver = version[i]
			if verhash < str(dd):
				var veri = str(verver).split(".")
				build = int(veri[2]) + 1
				build2 = int(veri[1])
				build3 = int(veri[0])
				if build > 999:
					build2 = build2 + 1
					build = "1"
				if build2 > 99:
					build3 = build3 + 1
					build2 = "1"
				verver = str(build3) + "." + str(build2) + "." + str(build)
				version = { "hash": str(dd), "ver": verver, "build": "Ver: " + str(build3) + "." + str(build2) + "_b" + str(build) }
				print ("VERSION AUTO CHANGED !!!!!!!!")
				savefile("res://version", version)
		
	
		$VBoxContainer/version.text =  version["build"]

	

	
# Notes load
	var notes_data = File.new()
	if not notes_data.file_exists("user://todo.txt"):
		savefile("user://todo.txt", "TODO:")
	notes_data.close()
	$VBoxContainer/TextEdit.text = loadfile("user://todo.txt", 1)
	
		
		
	
		
	
		
	#Подсоедининие функции pressed() от кнопки Button через скрипт
	get_node("VBoxContainer/Button").connect("pressed", self, "_on_Button_pressed")
	get_node("VBoxContainer/Button2").connect("pressed", self, "_on_Button2_pressed")
	get_node("VBoxContainer/Button3").connect("pressed", self, "_on_Button3_pressed")
	get_node("VBoxContainer/Button4").connect("pressed", self, "_on_Button4_pressed")
	get_node("VBoxContainer/Button5").connect("pressed", self, "_on_Button5_pressed")
	get_node("VBoxContainer/TextEdit").connect("text_changed", self, "_on_TextEdit_text_changed")
	#print(get_node("/root"))
	#Engine.set_window_size(Vector2(540, 960))
	
	
func _on_TextEdit_text_changed():
	savefile("user://todo.txt", $VBoxContainer/TextEdit.text)


func savefile(path, tostore):
	var notes = File.new()
	notes.open(path,File.WRITE)
	notes.store_string(to_json(tostore))
	notes.close()
	
func loadfile(path, json):
	var data
	var notes_data = File.new()
	if not notes_data.file_exists(path):
		return # Error! 
	notes_data.open(path, File.READ)
	if json == 1:
		data = parse_json(notes_data.get_as_text())
	if json == 0:
		data = notes_data.get_as_text()
	notes_data.close()
	return data
	
func _on_Button_pressed():
	$Banner.loadBAN("loadbig") # Загрузка баннера
	#get_node("VBoxContainer/Label").text = str(get_node("/root")) # размер/зрешение viewport
	#var cnt = $VBoxContainer/Label3.get_total_character_count()
	#get_node("VBoxContainer/Label2").text = str(cnt - 2)
	# Можно написать также:
	# $Label2.text = str(cnt - 2)
	print("----> " + str(buttonpressedtimes+1))
	
	get_tree().change_scene("res://maps/TestMap2.tscn")
	
	# Удаление кнопки после пяти нажатий
	buttonpressedtimes += 1
	if buttonpressedtimes == 5:
		$VBoxContainer/Button.queue_free()
		
	
	
func _on_Button2_pressed():
	get_tree().quit()
	
func _on_Button3_pressed():
	signals.loadgame = "true"
	get_tree().change_scene(resume_game("scene"))
	

	
	

	
func _on_Button5_pressed():
	get_tree().change_scene("res://maps/TestMap2.tscn")

func _on_Button4_pressed():
	get_tree().change_scene("res://tests/buttons/Settings.tscn")

func _process(delta):

	$VBoxContainer/Label4.text = "FPS: " + fps()
	$VBoxContainer/Label5.text = str(get_viewport().get_visible_rect().size)
	
	
func fps():			# FPS
	var det = str(Engine.get_frames_per_second())
	return det
	
func resume_game(level):
	var filenamee
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.

    # We need to revert the game state so we're not cloning objects during loading. This will vary wildly depending on the needs of a project, so take care with this step.
    # For our example, we will accomplish this by deleting savable objects.
	#var save_nodes = get_tree().get_nodes_in_group("gamesave")
	#for i in save_nodes:
	#	i.queue_free()

	# Load the file line by line and process that dictionary to restore the object it represents
	save_game.open("user://savegame.save", File.READ)
	while not save_game.eof_reached():
		var current_line = parse_json(save_game.get_as_text())
		# First we need to create the object and add it to the tree and set its position.
	#	var new_object = load(current_line["filename"]).instance()
	#	get_node(current_line["parent"]).add_child(new_object)
	#	new_object.position = Vector2(current_line["pos_x"], current_line["pos_y"])
		# Now we set the remaining variables.
		for i in current_line.keys():
			#if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
			#	continue
		#	new_object.set(i, current_line[i])
			if i == "filename" and level == "scene":
				return current_line[i]
				
	save_game.close()

	
