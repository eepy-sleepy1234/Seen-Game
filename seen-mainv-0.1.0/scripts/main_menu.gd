extends Control
@export var next_scene: PackedScene = load("res://scenes/laboratory.tscn")
@export var Credits: PackedScene = load("res://scenes/Credits/CreditsScene (2).tscn")


func _on_new_pressed() -> void:
	get_tree().change_scene_to_packed(next_scene)


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_packed(Credits)


func _on_audio_stream_player_finished() -> void:
	pass # Replace with function body.
	


func _on_exit_pressed() -> void:
	get_tree().quit()
