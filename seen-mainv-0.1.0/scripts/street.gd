extends Node2D

func wait_for_progress(target: int) -> void:
	while Globals.story_progress != target:
		await Globals.story_progress_changed

func _ready() -> void:
	Globals.story_progress = 22
	if Globals.story_progress == 22:
		Globals.story_progress += 1
		await wait_for_progress(24)
		Globals.listening = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
