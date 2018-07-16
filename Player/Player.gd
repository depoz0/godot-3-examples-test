extends KinematicBody2D

export var MOTION_SPEED = 100


func _ready():
	pass
	

func _process(delta):
	var motion = Vector2()
	
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		var gooo = get_global_mouse_position() - position
		move_and_slide(gooo)
		if $Sprite/AnimationPlayer.is_playing() == false:
			$Sprite/AnimationPlayer.play("Новая анимация")
		#print (gooo)
		#print (get_global_mouse_position())
		#print (position)


	
	
	if (Input.is_action_pressed("move_up")):
		motion += Vector2(0, -1)
		if $Sprite/AnimationPlayer.is_playing() == false:
			$Sprite/AnimationPlayer.play("Новая анимация")
		
	if (Input.is_action_pressed("move_down")):
		motion += Vector2(0, 1)
		if $Sprite/AnimationPlayer.is_playing() == false:
			$Sprite/AnimationPlayer.play("Новая анимация")
		
	if (Input.is_action_pressed("move_left")):
		motion += Vector2(-1, 0)
		if $Sprite/AnimationPlayer.is_playing() == false:
			$Sprite/AnimationPlayer.play("Новая анимация")
	
	if (Input.is_action_pressed("move_right")):
		motion += Vector2(1, 0)
		if $Sprite/AnimationPlayer.is_playing() == false:
			$Sprite/AnimationPlayer.play("Новая анимация")
		
	motion = motion.normalized() * MOTION_SPEED * delta
	move_and_collide(motion)

	