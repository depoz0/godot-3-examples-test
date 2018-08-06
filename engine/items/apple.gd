extends Area2D

var taken = false


func _ready():
	if get_node(".").is_in_group("ontree") == true:
		$Timer.start()
		
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):

	#pass


func _on_apple_body_entered(body):
	if not taken and body is preload("res://Player/Player.gd"):
		if get_node(".").is_in_group("ontree") == false:
			$AnimationPlayer.play("taken")
			taken = true
			signals.lives = signals.lives + 2



func _on_Timer_timeout():
	if get_node(".").is_in_group("ontree") == true:
		var pos = get_node(".").get_global_transform_with_canvas()
		get_node(".").scale.y = 1
		get_node(".").scale.x = 1
		get_node(".").position.y += randi() % 100
		get_node(".").position.x += randi() % 100
		get_node(".").z_index = -1
		get_node(".").remove_from_group("ontree")
