extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	var score = GlobalState.score
	
	if score == 0:
		text = "ok, that was pretty bad.\ntry again?"
	elif score == 1:
		text = "you've saved this alcoholic once. it wasn't enough."
	else:
		text = "you've saved this alcoholic " + str(GlobalState.score) + " times. he's still managed to die."


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
