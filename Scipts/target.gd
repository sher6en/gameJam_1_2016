extends Area2D

static var p1 := Vector2i(64,32)
static var p2 := Vector2i(239,143)
var current_side := randi_range(1, 4)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize_position()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
# generates a random integer point on the given side of a rectangle defined by 2 points
func randomize_position() -> void:
	
	var side = randi_range(1, 4)
	while(side == current_side):
		side = randi_range(1, 4)
	current_side = side
	
	var random_point := Vector2i.ZERO
	
	if side == 1:
		random_point.x = p1.x
		random_point.y = randi_range(p1.y+16, p2.y-16)
	elif side == 2:
		random_point.x = p2.x
		random_point.y = randi_range(p1.y+16, p2.y-16)
	elif side == 3:
		random_point.y = p1.y
		random_point.x = randi_range(p1.x+16, p2.x-16)
	elif side == 4: 
		random_point.y = p2.y
		random_point.x = randi_range(p1.x+16, p2.x-16)

	# snap to multiples of 16 using integer division
	random_point /= 16
	random_point *= 16
	
	print(random_point)
	
	random_point.x -= 1
	position = random_point  

func _on_area_entered(area: Area2D) -> void:
	
	# if ort touches the target it's game over
	if area.get_parent().name == "ort":
		get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
		return
	
	# otherwise move the target to a random location on another side 

	randomize_position()
	#self.set_position(spawn_loc)
