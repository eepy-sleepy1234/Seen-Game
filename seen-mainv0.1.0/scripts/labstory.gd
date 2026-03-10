extends Node2D

@onready var objectives: Label = $CanvasLayer/objectivebox/HBoxContainer/objectives

var new_text = ""
func _ready() -> void:
	await get_tree().create_timer(5).timeout
	Globals.story_progress = 1
	new_text = "\n - work at the computers on the right"
	for i in new_text:
		objectives.text += i
		await get_tree().create_timer(0.01).timeout
