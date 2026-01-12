extends Node2D


static var point_1 := Vector2i(64,32)
static var point_2 := Vector2i(239,143)
const MAX_HEALTH := 80.0
var health := MAX_HEALTH
const MAX_BATTERY_SPAWN_TIMER := 10.0
var battery_spawn_timer := MAX_BATTERY_SPAWN_TIMER

# Called when the node enters the scene tree for the first time.
@onready var target: Resource = preload("res://Scenes/target.tscn")
var target_instance = null
@onready var battery: Resource = preload("res://Scenes/battery.tscn")


# generates a random integer point on the perimeter of a rectangle defined by 2 points
#  
func get_random_point(p1: Vector2i, p2: Vector2i) -> Vector2i:
	var side := randi_range(1, 4)
	
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
	return random_point  
	
func _ready() -> void:
	
	target_instance = target.instantiate()
	add_child(target_instance)
	
	var spawn_loc: Vector2i = get_random_point(point_1, point_2) 
	target_instance.set_position(spawn_loc)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#self._ready()

	health = move_toward(health, 0, delta * 5)
	battery_spawn_timer = move_toward(battery_spawn_timer, 0, delta)
	if battery_spawn_timer == 0.0:
		var battery_instance : Node = battery.instantiate()
		add_child(battery_instance)
		battery_spawn_timer = 10.0
