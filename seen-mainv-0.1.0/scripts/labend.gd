extends Node2D
@onready var blackout: AnimationPlayer = $CanvasLayer/blackout/AnimationPlayer
@onready var textbox: MarginContainer = $CanvasLayer/textbox


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	blackout.play("fade in")
	await get_tree().create_timer(4).timeout
	textbox.write_text("human again")
	await get_tree().create_timer(3).timeout
	blackout.play("fade out")
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_packed(load("res://scenes/Credits/CreditsScene (2).tscn"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
