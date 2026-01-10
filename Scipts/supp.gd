extends CharacterBody2D


const SPEED = 50.0




func _physics_process(delta: float) -> void:
	
	#pass
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_x := Input.get_axis("ui_left", "ui_right")
	if direction_x==-1:
		$AnimatedSprite2D.play("left")
		velocity.x = direction_x * SPEED
	elif direction_x==1:
		$AnimatedSprite2D.play("right")
		velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	var direction_y := Input.get_axis("ui_up", "ui_down")
	print("x = ", direction_x, " y = ", direction_y)	
	if direction_y==-1:
		$AnimatedSprite2D.play("up")
		velocity.y = direction_y * SPEED
	elif direction_y==1:
		$AnimatedSprite2D.play("down")
		velocity.y = direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	move_and_slide()
