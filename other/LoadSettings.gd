extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var showfps = "false"
var todo = "false"

func _ready():
	load_data()
	get_node("FPS")
	
	
		
		
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func load_data():
	var save_data = File.new()
	if not save_data.file_exists("user://configGOdot.cfg"):
		return # Error! We don't have a save to load.


    # Load the file line by line and process that dictionary to restore the object it represents
	save_data.open("user://configGOdot.cfg", File.READ)
	
	var current_line = parse_json(save_data.get_as_text())
        # Now we set the remaining variables.
	for i in current_line.keys():
		if i == "showfps":
			showfps = current_line[i]
		if i == "todo":
			todo = current_line[i]
		
			     
	save_data.close()