extends CollisionShape2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		var pressed = event.pressed
		if pressed and Rect2(position.x-shape.size[0]/2, position.y-shape.size[0]/2, shape.size[0], shape.size[1]).has_point(get_global_mouse_position()):
			get_tree().change_scene_to_file("res://Scenes/game.tscn")
			
		
