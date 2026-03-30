extends Area2D

@onready var blackout: AnimationPlayer = $"../CanvasLayer/blackout/AnimationPlayer"
@export var next_area: String

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	Globals.listening = false
	blackout.play("end level")
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_packed(load(next_area))
