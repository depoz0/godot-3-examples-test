extends Node2D

func _ready():
	pass

func _process(delta):
	$Label.text = "FPS: " + fps()
	
func fps():			# FPS
	var det = str(Engine.get_frames_per_second())
	return det

