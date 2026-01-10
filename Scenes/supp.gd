extends CharacterBody2D


const SPEED = 50.0




func _physics_process(delta: float) -> void:
	
	var direction_x := Input.get_axis("ui_left", "ui_right")
	var direction_y := Input.get_axis("ui_up", "ui_down")
	var direction_size = sqrt(pow(direction_x, 2)+pow(direction_y,2))
	
	if direction_x==-1:
		$AnimatedSprite2D.play("left")
		velocity.x = direction_x * SPEED / direction_size
	elif direction_x==1:
		$AnimatedSprite2D.play("right")
		velocity.x = direction_x * SPEED / direction_size
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	print("x = ", direction_x, " y = ", direction_y)	
	if direction_y==-1:
		$AnimatedSprite2D.play("up")
		velocity.y = direction_y * SPEED / direction_size
	elif direction_y==1:
		$AnimatedSprite2D.play("down")
		velocity.y = direction_y * SPEED / direction_size
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	move_and_slide()
