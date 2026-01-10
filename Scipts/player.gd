extends CharacterBody2D

const SPEED = 100.0

@onready var current_target_position = Vector2i(0,0)
var current_path = []
var current_path_idx = 0

func _physics_process(delta: float) -> void:
	
	var target = get_parent().get_child(-1)
	if current_target_position != Vector2i(target.position+Vector2(1,0)): #A new target was created
		current_target_position = Vector2i(target.position+Vector2(1,0))
		current_path = []
		current_path_idx = 0
		
		var position_scaled16 = Vector2i(round(position/16))
		var target_position_scaled16 = Vector2i(round(current_target_position/16))
		
		
		var current_path_block = position_scaled16
		while (current_path_block != target_position_scaled16):
			current_path_block.x = move_toward(current_path_block.x, target_position_scaled16.x, 1)
			current_path_block.y = move_toward(current_path_block.y, target_position_scaled16.y, 1)
			var drunk_current_path_block = current_path_block + Vector2i(randi_range(-1, 1), randi_range(-1, 1))
			drunk_current_path_block.x = clampi(drunk_current_path_block.x, 4, 14)
			drunk_current_path_block.y = clampi(drunk_current_path_block.y, 2, 8)
			current_path.push_back(16*drunk_current_path_block+Vector2i(8, 0))
		current_path.push_back(current_target_position+Vector2i(8, 0))
	
	if len(current_path) != 0:
		
		var speed := SPEED
		if position.x != current_path[0].x && position.y != current_path[0].y:
			speed *= 0.707  # suspiciously close to 1 / sqrt(2)... 
			#If you are reading this, there is no such thing as a coincidence. Shit your pant
			
		position.x = move_toward(position.x, current_path[0].x, speed*delta)
		position.y = move_toward(position.y, current_path[0].y, speed*delta)

		if position == Vector2(current_path[0]):

			current_path.pop_front()


	
	#move_and_slide()
