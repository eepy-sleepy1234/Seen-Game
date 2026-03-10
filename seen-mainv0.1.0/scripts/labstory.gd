extends Node2D

@onready var objectives: Label = $CanvasLayer/objectivebox/HBoxContainer/objectives
@onready var top: AnimatedSprite2D = $"tube top/AnimatedSprite2D"
@onready var bottom: AnimatedSprite2D = $"tube bottom/AnimatedSprite2D"
@onready var camera: Camera2D = $player/Camera2D

var new_text = ""

func wait_for_progress(target: int) -> void:
	while Globals.story_progress != target:
		await Globals.story_progress_changed

func _ready() -> void:
	await get_tree().create_timer(5).timeout
	Globals.story_progress = 1
	new_text = "\n - work at the computers on the right"
	for i in new_text:
		objectives.text += i
		await get_tree().create_timer(0.01).timeout
	await wait_for_progress(2)
	await get_tree().create_timer(2).timeout
	Globals.listening = true
	Globals.story_progress = 3
	top.play("oh no")
	bottom.play("oh no")
	camera.screen_shake(20, 1)
