extends Area2D

var taken = false
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


func _on_lei_body_entered(body):
	if not taken and body is preload("res://Player/Player.gd"):
		$AnimationPlayer.play("taken")
		taken = true
		signals.lei = true