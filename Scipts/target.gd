extends Area2D

# top left and bottom right corner positions in gridspace
const map_min_pos := Vector2i(4, 2)
const map_max_pos := Vector2i(14, 8)

var current_side := randi_range(1, 4)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize_position()
	modulate.r *= 1.3
	modulate.g *= 1.1
	modulate.b *= 1.1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# set the opacity of the target to be propotional to the distance to ort.
	# in effect, this makes the target hidden until ort is sufficiently close.
	# this makes the target position less predictable, and supp has to always be
	# around ort to guess where it's gonna be, matching closer the theme / story.
	modulate.a = 3 - (position + Vector2(8, 8)).distance_to($"../ort".position) / 16.0

	
# generates a random integer point on the given side of a rectangle defined by 2 points
func randomize_position() -> void:
	
	var side = randi_range(1, 4)
	while(side == current_side):
		side = randi_range(1, 4)
	current_side = side
	
	var random_point := Vector2i.ZERO
	
	if side == 1:
		random_point.x = map_min_pos.x
		random_point.y = randi_range(map_min_pos.y + 1, map_max_pos.y - 1)
	elif side == 2:
		random_point.x = map_max_pos.x
		random_point.y = randi_range(map_min_pos.y + 1, map_max_pos.y - 1)
	elif side == 3:
		random_point.y = map_min_pos.y
		random_point.x = randi_range(map_min_pos.x + 1, map_max_pos.x - 1)
	elif side == 4: 
		random_point.y = map_max_pos.y
		random_point.x = randi_range(map_min_pos.x + 1, map_max_pos.x - 1)

	# convert from gridspace to worldspace 
	random_point *= 16
	random_point.x -= 1
	position = random_point  

func _on_area_entered(area: Area2D) -> void:
	
	# if ort touches the target it's game over
	if area.get_parent().name == "ort":
		print(area.get_parent())
		get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
		return
	
	# otherwise move the target to a random location on another side 

	randomize_position()
	#self.set_position(spawn_loc)
