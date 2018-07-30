extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	


		
	# Game save load:	
	if signals.loadgame == "true":
		loadgameuu()
		signals.loadgame = "false"
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func save():
	var save_dict = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"pos_x" : $Player/KinematicBody2D.position.x, # Vector2 is not supported by JSON
		"pos_y" : $Player/KinematicBody2D.position.y#,
		#"level" : self.get_script().get_path()
	}
	return save_dict
	
func loadgameuu():

	var filenamee
	var save_game = File.new()
	if not save_game.file_exists("res://savegame.save"):
		return # Error! We don't have a save to load.

	save_game.open("res://savegame.save", File.READ)
	while not save_game.eof_reached():
		var current_line = parse_json(save_game.get_as_text())
		$Player/KinematicBody2D.position.x = current_line["pos_x"]
		$Player/KinematicBody2D.position.y = current_line["pos_y"]
		break
	save_game.close()
	
