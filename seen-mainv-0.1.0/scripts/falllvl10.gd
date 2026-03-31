extends Area2D
@onready var blackout: AnimationPlayer = $"../CanvasLayer/blackout/AnimationPlayer"
@onready var player: CharacterBody2D = %player

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	blackout.play("end level")
	Globals.listening = false
	await get_tree().create_timer(0.5).timeout
	var reload = get_tree().reload_current_scene()
