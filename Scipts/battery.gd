extends Area2D

@onready var game = $".."


	
func _ready():
	position = 16 * Vector2i(randi_range(5, 13), randf_range(3, 7))

func _on_area_entered(area: Area2D) -> void:
	if area.get_parent().name == "supp":
		game.health = game.MAX_HEALTH
		game.battery_spawn_timer = game.MAX_BATTERY_SPAWN_TIMER
		self.queue_free()
