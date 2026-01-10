extends Area2D

static var point_1: Vector2i = Vector2i(64,32)
static var point_2: Vector2i = Vector2i(239,143)
var outside: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func get_random_point(p1: Vector2i, p2: Vector2i, side) -> Vector2i:
	var return_value: Vector2i = Vector2i(0,0)


	#var rand_x: int
	
	var random_point = Vector2i.ZERO
	
	if side == 1:
		random_point.x = p1.x/16
		random_point.y = randi_range(p1.y+16, p2.y-16)/16
	elif side == 2:
		random_point.x = p2.x/16
		random_point.y = randi_range(p1.y+16, p2.y-16)/16
	elif side == 3:
		random_point.y = p1.y/16
		random_point.x = randi_range(p1.x+16, p2.x-16)/16
	elif side == 4: 
		random_point.y = p2.y/16
		random_point.x = randi_range(p1.x+16, p2.x-16)/16
	
  
	random_point *= 16
	random_point.x -= 1
	return random_point  
	

func _on_area_entered(area: Area2D) -> void:
	if area.get_parent().name == "ort":
		print("ort touch target")
		get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
	var random_num = randi_range(1, 4)
	while(random_num == outside):
		random_num = randi_range(1, 4)
	outside = random_num
	var spawn_loc: Vector2i = get_random_point(point_1, point_2, outside)
	self.set_position(spawn_loc)
	#pass # Replace with function body.
