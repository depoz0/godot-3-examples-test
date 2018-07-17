extends MarginContainer






var buttonpressedtimes = 0

func _ready():
	if get_tree().paused == true: #снятие с паузы
		get_tree().paused = false
	if $LoadSettings.showfps == "true":
		$LoadSettings/FPS.show()
	else:
		$LoadSettings/FPS.hide()
		
# Auto Versioning (testing)
	var notes = File.new()
	var dd = notes.get_md5("res://default_env.tres")
	
	var version = loadfile("res://version", 1)
	var verhash
	var verver
	print (version)
	if version["ver"] != null:
		for i in version.keys():
			if i == "hash":
				verhash = version[i]
			if i == "ver":
				verver = version[i]
		if verhash != dd:
			var veri = str(verver).split(".")
			var build = int(veri[2]) + 1
			verver = veri[0] + "." + veri[1] + "." + str(build)
			version = { "hash": dd, "ver": verver }
			print ("VERSION AUTO CHANGED !!!!!!!!")
			savefile("res://version.txt", version)
	version = { "hash": dd, "ver": verver }

	$VBoxContainer/version.text = str(verver)

	

	
# Notes load
	$VBoxContainer/TextEdit.text = loadfile("res://todo.txt", 1)
	
		
		
	
		
	
		
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
	savefile("res://todo.txt", $VBoxContainer/TextEdit.text)


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
	print("lolikiiii " + str(buttonpressedtimes+1))
	
	
	
	# Удаление кнопки после пяти нажатий
	buttonpressedtimes += 1
	if buttonpressedtimes == 5:
		$VBoxContainer/Button.queue_free()
		
	
	
func _on_Button2_pressed():
	get_tree().quit()
	
func _on_Button3_pressed():
	get_tree().change_scene("res://maps/TestMap.tscn")
	
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
	