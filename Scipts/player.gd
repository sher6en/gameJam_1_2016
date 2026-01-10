extends CharacterBody2D

const SPEED = 10.0

@onready var current_target_position = Vector2i(0,0)
var current_path = []
var current_path_idx = 0
func _physics_process(delta: float) -> void:
	
	var target = get_parent().get_child(-1)
	if current_target_position != Vector2i(target.position): #A new target was created
		print("Old target position ", current_target_position)
		current_target_position = Vector2i(target.position)
		current_path = []
		current_path_idx = 0
		print("New target position ", current_target_position)
		
		var position_scaled16 = Vector2i(round(position/16))
		var target_position_scaled16 = Vector2i(round(current_target_position/16))
		
		print("ort pos s16: ", position_scaled16, " target pos s16:", target_position_scaled16)
		var current_path_block = position_scaled16
		while (current_path_block.x != target_position_scaled16.x):
			current_path.push_back(16*current_path_block+Vector2i(8,0))
			current_path_block.x = move_toward(current_path_block.x, target_position_scaled16.x, 1)
			print(current_path, current_path_block/8)
		while (current_path_block.y != target_position_scaled16.y):
			current_path_block.y = move_toward(current_path_block.y, target_position_scaled16.y, 1)
			current_path.push_back(16*current_path_block)
			print(current_path, current_path_block/8+Vector2i(8,0))
		current_path.push_back(current_target_position+Vector2i(8,0))
	
	if len(current_path) != 0:	
		position.x = move_toward(position.x, current_path[0].x, SPEED*delta)
		position.y = move_toward(position.y, current_path[0].y, SPEED*delta)

		if position == Vector2(current_path[0]):
			print("got to step, popping")
			current_path.pop_front()
			print("current path ", current_path)

		
	move_and_slide()
