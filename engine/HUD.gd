extends Node2D

var dialog = ["Hello!", "I'm just relaxing...", "Whaaat?", "What a beautiful day..."]
var page = 0

func _ready():
	$Polygon2D/RichTextLabel.set_bbcode(dialog[page])
	$Polygon2D/RichTextLabel.set_visible_characters(0)
	$Polygon2D/RichTextLabel.set_process_input(true)
	
func _input(event):
	if event is InputEventMouseButton  and event.is_pressed() and event.button_index == 1:
		if $Polygon2D/RichTextLabel.get_visible_characters() > $Polygon2D/RichTextLabel.get_total_character_count():
			if page < dialog.size()-1:
				page += 1
				$Polygon2D/RichTextLabel.set_bbcode(dialog[page])
				$Polygon2D/RichTextLabel.set_visible_characters(0)
		else:
			$Polygon2D/RichTextLabel.set_visible_characters($Polygon2D/RichTextLabel.get_total_character_count())
				
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Button_pressed():
	var button_lei = get_node("../../Sprite2")
	if button_lei.is_visible() == true:
		signals.leiinhand = false
		button_lei.hide()
	elif button_lei.is_visible() == false:
		signals.leiinhand = true
		button_lei.show()
	pass # replace with function body


func _on_Timer_timeout():
	$Polygon2D/RichTextLabel.set_visible_characters($Polygon2D/RichTextLabel.get_visible_characters()+1)
