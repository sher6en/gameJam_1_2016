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

	
func _ready() -> void:
	
	target_instance = target.instantiate()
	add_child(target_instance)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#self._ready()

	health = move_toward(health, 0, delta * 5)
	battery_spawn_timer = move_toward(battery_spawn_timer, 0, delta)
	if battery_spawn_timer == 0.0:
		var battery_instance : Node = battery.instantiate()
		add_child(battery_instance)
		battery_spawn_timer = 10.0
