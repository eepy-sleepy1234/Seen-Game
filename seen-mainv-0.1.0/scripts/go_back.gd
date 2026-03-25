extends Node2D
@onready var blackout: AnimationPlayer = $"../CanvasLayer/blackout/AnimationPlayer"

@export var go_to: PackedScene
@export var progress = 0
var timer = 0
func _ready() -> void:
	while timer < 10:
		timer += 1
		await get_tree().create_timer(0.1).timeout

func _on_area_2d_body_entered(body: Node2D) -> void:
	if timer >= 10 and progress <= Globals.story_progress:
		Globals.listening = false
		blackout.play("fade out")
		await get_tree().create_timer(3).timeout
		get_tree().change_scene_to_packed(go_to)
