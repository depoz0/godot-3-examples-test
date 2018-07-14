extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var speed = 100
var screensize



func _ready():
	screensize = get_viewport().size
	#set_process(true)
	# Called when the node is added to the scene for the first time.
	# Initialization here
	
	pass

func _process(delta):
	var vel = Vector2() 
	if Input.is_action_pressed("move_right"):
		vel.x += 1
		if !$Sprite2/AnimationPlayer.is_playing():
			$Sprite2/AnimationPlayer.play("right")
	if Input.is_action_just_released("move_right"):
		$Sprite2/AnimationPlayer.stop(false)
		$Sprite2.frame = 4
		
	if Input.is_action_pressed("move_left"):
		vel.x -= 1
		if !$Sprite2/AnimationPlayer.is_playing():
			$Sprite2/AnimationPlayer.play("left")
	if Input.is_action_just_released("move_left"):
		$Sprite2/AnimationPlayer.stop(false)
		$Sprite2.frame = 10
		
	if Input.is_action_pressed("move_down"):
		vel.y += 1
		if !$Sprite2/AnimationPlayer.is_playing():
			$Sprite2/AnimationPlayer.play("down")
	if Input.is_action_just_released("move_down"):
		$Sprite2/AnimationPlayer.stop(false)
		$Sprite2.frame = 7
		
	if Input.is_action_pressed("move_up"):
		vel.y -= 1
		if !$Sprite2/AnimationPlayer.is_playing():
			$Sprite2/AnimationPlayer.play("up")
	if Input.is_action_just_released("move_up"):
		$Sprite2/AnimationPlayer.stop(false)
		$Sprite2.frame = 1
	
	

	
	#else:
		#$Sprite2/AnimationPlayer.stop("down")
	
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
