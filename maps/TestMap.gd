extends TileMap

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	if $LoadSettings.showfps == "true":
		$LoadSettings/FPS.show()
	else:
		$LoadSettings/FPS.hide()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
