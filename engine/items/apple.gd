# apple.gd
# 1 apple need to be in scene background to work!!!

extends Area2D

var taken = false
var trees
var treescount

func _ready():

		
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	
	treescount = get_tree().get_nodes_in_group("appletree") #getting trees nodes

	for i in treescount:
		var emptytree = i
		var nods = i.get_tree().get_nodes_in_group("ontree") #getting apples on all trees
		for i in nods: # for each apple check grow timer/start
			if i.get_node("Timer").time_left == 0:
				i.get_node("Timer").start()
		#nods = i.get_children().size()
		nods = i.get_children()
		var gg = 0
		for i in nods:
			if i.is_in_group("ontree"):
				gg = 1
		#print (nods, " pausa ")
		if signals.leiinhand == true and signals.treeappleID == i and gg == 0:
			
			print ("Planted")
			for i in randi() % 5 + 1: #how many apples to make on tree
				var apple = load("res://engine/items/apple.tscn")
				var apple2 = apple.instance()
				var tseed = str(randi() % 9999999 + 1)
				apple2.set_name("treeapple" + tseed)
				emptytree.add_child(apple2)
				emptytree.get_node("treeapple"+tseed).add_to_group("ontree")
				emptytree.get_node("treeapple"+tseed).scale.y = 0.45
				emptytree.get_node("treeapple"+tseed).scale.x = 0.45
				emptytree.get_node("treeapple"+tseed+"/Timer").start()
				emptytree.get_node("treeapple"+tseed).position.y += rand_range(-50, 5)
				emptytree.get_node("treeapple"+tseed).position.x += rand_range(-20, 20)
	#if get_node(".").is_in_group("ontree") == true:



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
