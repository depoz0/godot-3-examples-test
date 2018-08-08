extends Node2D


# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	#fix
	signals.lei = false
		
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
	var apple1 = 1
	var apple2 = 1
	var apple3 = 1
	var appletree1 = 1
	var appletree2 = 1
	var appletree3 = 1
	
	if !$Node2D/apple:
		apple1 = 0
	if !$Node2D/apple2:
		apple2 = 0
	if !$Node2D/apple3:
		apple3 = 0
	if !$Navigation2D/TileMap/treeA1/appletree1:
		appletree1 = 0
	if !$Navigation2D/TileMap/treeA1/appletree2:
		appletree2 = 0
	if !$Navigation2D/TileMap/treeA1/appletree3:
		appletree3 = 0

		
	var save_dict = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"pos_x" : $Player/KinematicBody2D.position.x, # Vector2 is not supported by JSON
		"pos_y" : $Player/KinematicBody2D.position.y,
		"lives" : signals.lives,
		"lei" : signals.lei,
		"apple" : {"1" : apple1, "2" : apple2, "3" : apple3},
		"appletree" : {"1" : appletree1, "2" : appletree2, "3" : appletree3}
		#"level" : self.get_script().get_path()
	}
	return save_dict
	
func loadgameuu():

	var filenamee
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.

	save_game.open("user://savegame.save", File.READ)
	while not save_game.eof_reached():
		var current_line = parse_json(save_game.get_as_text())
		$Player/KinematicBody2D.position.x = current_line["pos_x"]
		$Player/KinematicBody2D.position.y = current_line["pos_y"]
		signals.lives = current_line["lives"]
		signals.lei = current_line["lei"]
		if current_line["lei"] == true:
			$Node2D/lei.queue_free()
		if current_line["apple"]["1"] == 0:
			$Node2D/apple.queue_free()
		if current_line["apple"]["2"] == 0:
			$Node2D/apple2.queue_free()
		if current_line["apple"]["3"] == 0:
			$Node2D/apple3.queue_free()
		if current_line["appletree"]["1"] == 0:
			$Navigation2D/TileMap/treeA1/appletree1.queue_free()
		if current_line["appletree"]["2"] == 0:
			$Navigation2D/TileMap/treeA1/appletree2.queue_free()
		if current_line["appletree"]["3"] == 0:
			$Navigation2D/TileMap/treeA1/appletree3.queue_free()
		
		
		break
	save_game.close()
	


	




func _on_Area2D_body_entered(body):
	
	if body is preload("res://Player/Player.gd"):
		#signals.treeappleID = body.add_user_signal(
		#print (body.position.x)
		#print (body.position.y)
		#print (body)
		for tree in get_tree().get_nodes_in_group("appletree"):
			#print (tree.position, " ", Vector2(body.position.x, body.position.y))
			#print (tree.position - Vector2(body.position.x, body.position.y))
			var vec = tree.position - Vector2(body.position.x, body.position.y)
			if vec.x < 100 and vec.x > -100 and vec.y > -100 and vec.y < 100:
				signals.treeappleID = tree
				print (tree, " OK OK OK")
				

func _on_Area2D_body_exited(body):
	if body is preload("res://Player/Player.gd"):
		signals.treeappleID = null