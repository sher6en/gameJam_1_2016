extends Node2D


static var point_1: Vector2i = Vector2i(64,32)
static var point_2: Vector2i = Vector2i(239,143)
const MAX_HEALTH := 80.0
var health := 80.0
const MAX_BATTERY_SPAWN_TIMER = 10.0
var battery_spawn_timer := 10.0

# Called when the node enters the scene tree for the first time.
@onready var target: Resource = preload("res://Scenes/target.tscn")
@onready var battery: Resource = preload("res://Scenes/battery.tscn")


func get_random_point(p1: Vector2i, p2: Vector2i) -> Vector2i:
	var return_value: Vector2i = Vector2i(0,0)
	#var x_value: int = randi_range(p1.x, p2.x)/16	
	#var y_value: int = randi_range(p1.y, p2.y)/16
	#var random_point: Vector2i = Vector2i((x_value*16)-1, y_value*16)
	var side: int = randi_range(1, 4)
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
	print(random_point)

	random_point *= 16
	random_point.x -= 1
	return random_point  
	
func _ready() -> void:
	
	var target_instance: Node = target.instantiate()
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
