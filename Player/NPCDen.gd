extends KinematicBody2D
onready var follow = get_node("../")
var go = true

var speed = 0.1
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	

		
	if follow.offset > 0 and follow.offset < 375 and $Timer.is_stopped() and go == true:
		follow.set_unit_offset(follow.get_unit_offset() + speed * delta)
	if follow.offset >= 375 and go == true:
		$AnimationPlayer.stop()
		$Sprite.frame = 4
		$Timer.start()
		#follow.set_unit_offset(376)
		go = false
	if follow.offset > 0 and $Timer.is_stopped() and go == false:
		follow.set_unit_offset(follow.get_unit_offset() - speed * delta)
	if follow.offset <= 1 and go == false:
		$AnimationPlayer.stop()
		$Sprite.frame = 10
		$Timer.start()
		go = true
	
		
		
	
		
	#follow.set_unit_offset(follow.get_unit_offset() + speed * delta)

	if follow.offset > 1 and follow.offset < 50:
		if not $AnimationPlayer.is_playing():
			$AnimationPlayer.play("walkdown")
		if $AnimationPlayer.get_current_animation() == "walkright":
			$AnimationPlayer.set_current_animation("walkup")
	if follow.offset > 51 and follow.offset < 210:
		if $AnimationPlayer.get_current_animation() == "walkdown":
			$AnimationPlayer.set_current_animation("walkleft")
		if $AnimationPlayer.get_current_animation() == "walkdown2":
			$AnimationPlayer.set_current_animation("walkright")
	if follow.offset > 211 and follow.offset < 375:
		if $AnimationPlayer.get_current_animation() == "walkleft":
			$AnimationPlayer.set_current_animation("walkup")
		if $Sprite.frame == 4:
			$AnimationPlayer.set_current_animation("walkdown2")
		
	
	pass


	
	
