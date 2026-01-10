extends Node2D

var point_1: Vector2 = Vector2(63,32)
var point_2: Vector2 = Vector2(239,144)
# Called when the node enters the scene tree for the first time.

func get_random_point(p1: Vector2, p2: Vector2) -> Vector2:
	
	var x_value: float = randf_range(p1.x, p2.x)
	var y_value: float = randf_range(p1.y, p2.y)
	var random_point: Vector2 = Vector2(x_value, y_value)
	
	return(random_point)
	
func _ready() -> void:
	randomize() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
