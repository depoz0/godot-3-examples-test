extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Button_pressed():
	var button_lei = get_node("../../Sprite2")
	if button_lei.is_visible() == true:
		button_lei.hide()
	elif button_lei.is_visible() == false:
		button_lei.show()
	pass # replace with function body
