extends Node2D

@onready var blackout: AnimationPlayer = $CanvasLayer/blackout/AnimationPlayer
@onready var player: CharacterBody2D = %player
@onready var player_animation: AnimationPlayer = $player/AnimationPlayer
@onready var textbox: MarginContainer = $CanvasLayer/textbox
@onready var objectives: Sprite2D = $CanvasLayer/objectives
@onready var key: Node2D = $key
@onready var inventory: AnimationPlayer = $CanvasLayer/inventory/AnimationPlayer
@onready var keyanim: AnimationPlayer = $CanvasLayer/keyanimation/AnimationPlayer
@onready var old_ghost_guy: Node2D = $"old ghost guy"
@onready var camera: Node2D = $"security camera/PointLight2D"
@onready var point_light_2d: PointLight2D = $PointLight2D
@onready var oldGuyOh = $"Old Guy Oh"

var new_text = ""
var next_scene: PackedScene = load("uid://ckyb4hj0cb02f")
var level_scene: PackedScene = load("uid://dnv1w0esogpm2")
@onready var security_camera: Node2D = $"security camera"

func wait_for_progress(target: int) -> void:
	while Globals.story_progress != target:
		await Globals.story_progress_changed

func _ready() -> void:
	blackout.play("fade in")
	security_camera.visible = false
	if Globals.story_progress == 9:
		Globals.listening = false
		Globals.story_progress += 1
		player_animation.play("falling")
		await get_tree().create_timer(0.1).timeout
		player.is_ghost = 0
		await get_tree().create_timer(5).timeout
		Globals.listening = true
		Globals.story_progress += 1
		await wait_for_progress(12)
		await get_tree().create_timer(2).timeout
		new_text = "\n - go walk through those boxes"
		objectives.write(new_text)
		await wait_for_progress(13)
		textbox.write_text("Told you so")
		await get_tree().create_timer(2).timeout
		Globals.listening = true
		textbox.close_box()
		await wait_for_progress(15)
		await get_tree().create_timer(2).timeout
		new_text = "\n - leave the basement from the stairs"
		objectives.write(new_text)
		await wait_for_progress(16)
		textbox.write_text("the door's locked. There's gotta be a key somewhere")
		await get_tree().create_timer(4).timeout
		new_text = "\n - find the key"
		objectives.write(new_text)
		textbox.close_box()
		await wait_for_progress(17)
		key.visible = false
		await get_tree().create_timer(0.3).timeout
		inventory.play("unlock")
		keyanim.play("get key")
		await get_tree().create_timer(1.6).timeout
		new_text = "\n - unlock the door"
		objectives.write(new_text)
		await get_tree().create_timer(0.1).timeout
		Globals.listening = true
		await wait_for_progress(18)
		keyanim.play("use")
		blackout.play("fade out")
		await get_tree().create_timer(3).timeout
		get_tree().change_scene_to_packed(next_scene)
	elif Globals.story_progress == 28:
		key.queue_free()
		for i in range(18):
			old_ghost_guy.dialogue.pop_front()
			old_ghost_guy.dialogue_progress.pop_front()
		Globals.listening = false
		Globals.story_progress += 1
		player_animation.play("falling")
		await get_tree().create_timer(0.1).timeout
		player.is_ghost = 0
		await get_tree().create_timer(5).timeout
		Globals.listening = true
		Globals.story_progress += 1
		await wait_for_progress(32)
		new_text = "\n - walk through the stairs"
		objectives.write(new_text)
		await wait_for_progress(33)
		textbox.write_text("Why can I walk through everything besides these stairs?")
		await get_tree().create_timer(4).timeout
		textbox.continue_text("and why can I talk to people and ghosts?")
		await get_tree().create_timer(3).timeout
		textbox.continue_text("let me try something")
		new_text = "\n - deactivate the security camera"
		objectives.write(new_text)
		await get_tree().create_timer(3).timeout
		textbox.close_box()
		await wait_for_progress(34)
		security_camera.queue_free()
		camera.queue_free()
		point_light_2d.queue_free()
		await get_tree().create_timer(0.01).timeout
		Globals.listening = true
		new_text = "\n - walk through the stairs now"
		objectives.write(new_text)
		await wait_for_progress(35)
		blackout.play("fade out")
		await get_tree().create_timer(3).timeout
		get_tree().change_scene_to_packed(level_scene)
