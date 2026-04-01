extends Node2D
@onready var blackout: AnimationPlayer = $CanvasLayer/blackout/AnimationPlayer
@onready var player: CharacterBody2D = %player
@onready var docker: AnimationPlayer = $"docker log lesg/AnimationPlayer"
@onready var textbox: MarginContainer = $CanvasLayer/textbox
@onready var docker_log_lesg: AnimatedSprite2D = $"docker log lesg"
var next_scene: PackedScene = preload("uid://b6a3qwgtgls5y")
func wait_for_progress(target: int) -> void:
	while Globals.story_progress != target:
		await Globals.story_progress_changed

func _ready() -> void:
	if Globals.story_progress == 22:
		Globals.story_progress += 1
		blackout.play("fade in")
		Globals.listening = false
		player.direction = Vector2(0, 1)
		await get_tree().create_timer(0.5).timeout
		Globals.listening = true
		await wait_for_progress(24)
		Globals.listening = false
		docker.play("walk")
		await get_tree().create_timer(4.5).timeout
		textbox.write_text("Hey, I recognize you! Why don't you come back to the hospital with me.")
		await get_tree().create_timer(5).timeout
		textbox.close_box()
		docker.play("walk 2 the electric boogaloo")
		Globals.story_progress += 1
		await wait_for_progress(26)
		blackout.play("fade out")
		await get_tree().create_timer(3).timeout
		get_tree().change_scene_to_packed(next_scene)
