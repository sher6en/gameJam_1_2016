extends CharacterBody2D


const SPEED = 10.0
const JUMP_VELOCITY = -400.0


@onready var target_position = $"../target".position

func _physics_process(delta: float) -> void: 
	var astar_grid = AStarGrid2D.new()
	astar_grid.region = Rect2i(0, 0, 18, 10)
	astar_grid.cell_size = Vector2(16,16)
	astar_grid.update()
	var path = astar_grid.get_id_path(Vector2i(position/16), Vector2i(target_position/16))
	
	if len(path) > 0:
		if Vector2i(position)==16*path[0]:
			position.x = move_toward(position.x, 16*path[1].x, SPEED*delta)
			position.y = move_toward(position.y, 16*path[1].y, SPEED*delta)
		else:
			position.x = move_toward(position.x, 16*path[0].x, SPEED*delta)
			position.y = move_toward(position.y, 16*path[0].y, SPEED*delta)
		
		#print("path targetpos", Vector2i(position)/16, path[path_idx]/16, target_position/16, "\n", path, "\n")
		#position.x = move_toward(position.x, 16*path[path_idx].x, SPEED*delta)
		#position.y = move_toward(position.y, 16*path[path_idx].y, SPEED*delta)
	
	
	move_and_slide()
