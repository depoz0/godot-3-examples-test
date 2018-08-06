extends KinematicBody2D

export var MOTION_SPEED = 100



#SOunds
onready var soundsteptimer = get_node("walkgrass/Timer")
onready var grasssteps = get_node("walkgrass")

func _ready():
	
	# Game settings FPS show/hide:
	if $CanvasLayer/LoadSettings.showfps == "true":
		$CanvasLayer/LoadSettings/FPS/Label.show()
	else:
		$CanvasLayer/LoadSettings/FPS/Label.hide()
		
	
		
	

func _process(delta):
	
	#items in bar
	if signals.lei == false:
		$CanvasLayer/HUD/Button.hide()
	if signals.lei == true:
		$CanvasLayer/HUD/Button.show()

		
		
		
	#lives
	$CanvasLayer/HUD/lives.text = str(signals.lives)
	
	var motion = Vector2()
	
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		var gooo = (get_global_mouse_position() - position).normalized() * MOTION_SPEED 
		move_and_slide(gooo)
		if $Sprite/AnimationPlayer.is_playing() == false:
			$Sprite/AnimationPlayer.play("Новая анимация")
		if not grasssteps.playing and soundsteptimer.is_stopped():
			grasssteps.play()
			soundsteptimer.start()
		#print (gooo)
		#print (get_global_mouse_position())
		#print (position)
	if Input.is_mouse_button_pressed(BUTTON_RIGHT):
		$Camera2D.set_zoom(Vector2(2, 2))


	
	
	if (Input.is_action_pressed("move_up")):
		motion += Vector2(0, -1)
		if $Sprite/AnimationPlayer.is_playing() == false:
			$Sprite/AnimationPlayer.play("Новая анимация")
		if not grasssteps.playing and soundsteptimer.is_stopped():
			grasssteps.play()
			soundsteptimer.start()
		
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
		
	if (Input.is_action_just_pressed("move_run")):
		MOTION_SPEED = 200
	if (Input.is_action_just_released("move_run")):
		MOTION_SPEED = 100
		
		
	motion = motion.normalized() * MOTION_SPEED * delta
	move_and_collide(motion)
	
	if signals.lives < 0:
		$".".queue_free()
		
	

			#if item (lei) in hand
	if $Sprite2.is_visible() == true and signals.treeap == true and !get_node("../../Navigation2D/TileMap/treeA1/treeapple"):
		
		print("tetett")
		var apple = load("res://engine/items/apple.tscn")
		var apple2 = apple.instance()
		apple2.set_name("treeapple")
		get_node("../../Navigation2D/TileMap/treeA1").add_child(apple2)
		get_node("../../Navigation2D/TileMap/treeA1/treeapple").add_to_group("ontree")
		get_node("../../Navigation2D/TileMap/treeA1/treeapple").scale.y = 0.45
		get_node("../../Navigation2D/TileMap/treeA1/treeapple").scale.x = 0.45
		get_node("../../Navigation2D/TileMap/treeA1/treeapple/Timer").start()
	