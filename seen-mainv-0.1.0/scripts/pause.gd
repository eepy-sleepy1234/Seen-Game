extends Node2D

var pause = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if not pause:
			visible = !visible
			get_tree().paused = !get_tree().paused
			pause = true
		else:
			get_tree().paused = false
			pause = false
			get_tree().change_scene_to_packed(load("res://scenes/Main Menu.tscn"))
	elif Input.is_action_just_pressed("interact") or Input.is_action_just_pressed("drop") or Input.is_action_just_pressed("move_down") or Input.is_action_just_pressed("move_up") or Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
		if pause:
			visible = !visible
			get_tree().paused = !get_tree().paused
			pause = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
