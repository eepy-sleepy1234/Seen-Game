extends Node2D

@onready var objectives: Label = $CanvasLayer/objectivebox/HBoxContainer/objectives
@onready var top: AnimatedSprite2D = $"tube top/AnimatedSprite2D"
@onready var bottom: AnimatedSprite2D = $"tube bottom/AnimatedSprite2D"
@onready var camera: Camera2D = $player/Camera2D
@onready var red_flash: AnimationPlayer = $"CanvasLayer/red flash/AnimationPlayer"
@onready var textbox: MarginContainer = $CanvasLayer/textbox
@onready var player: CharacterBody2D = $player
@onready var blackout: AnimationPlayer = $CanvasLayer/blackout/AnimationPlayer
@export var next_scene: PackedScene = preload("uid://btq6kag0yd6k")
var new_text = ""

func wait_for_progress(target: int) -> void:
	while Globals.story_progress != target:
		await Globals.story_progress_changed

func _ready() -> void:
	blackout.play("fade in")
	await get_tree().create_timer(5).timeout
	Globals.story_progress = 1
	new_text = "\n - work at the computers on the right"
	for i in new_text:
		objectives.text += i
		await get_tree().create_timer(0.01).timeout
	await wait_for_progress(2)
	await get_tree().create_timer(2).timeout
	Globals.listening = true
	Globals.story_progress += 1
	new_text = "\n - check the readings on the tank"
	for i in new_text:
		objectives.text += i
		await get_tree().create_timer(0.01).timeout
	await wait_for_progress(4)
	await get_tree().create_timer(2).timeout
	textbox.write_text("everything looks good")
	await get_tree().create_timer(2.5).timeout
	textbox.close_box()
	Globals.listening = true
	new_text = "\n - fiddle with the test tubes to pass the time"
	for i in new_text:
		objectives.text += i
		await get_tree().create_timer(0.01).timeout
	await wait_for_progress(5)
	await get_tree().create_timer(2).timeout
	Globals.listening = true
	Globals.story_progress += 1
	new_text = "\n - do some more work on the computers"
	for i in new_text:
		objectives.text += i
		await get_tree().create_timer(0.01).timeout
	await wait_for_progress(7)
	await get_tree().create_timer(3).timeout
	Globals.story_progress += 1
	top.play("oh no")
	bottom.play("oh no")
	camera.screen_shake(20, 1)
	Globals.listening = false
	red_flash.play("red flash")
	textbox.write_text("I need to shut this down")
	await get_tree().create_timer(3).timeout
	Globals.listening = true
	new_text = "\n - push the emergency stop button"
	for i in new_text:
		objectives.text += i
		await get_tree().create_timer(0.01).timeout
	textbox.close_box()
	await wait_for_progress(9)
	red_flash.stop(false)
	top.play("default")
	bottom.play("default")
	await get_tree().create_timer(2).timeout
	textbox.write_text("phew, that was a close one")
	await get_tree().create_timer(3).timeout
	player.direction = Vector2(1, 0)
	player.sprite.flip_h = true
	player.sprite.play("side")
	textbox.close_box()
	await get_tree().create_timer(0.5).timeout
	player.direction = Vector2(0, 1)
	player.sprite.play("down")
	await get_tree().create_timer(1.1).timeout
	player.direction = Vector2(1, 0)
	player.sprite.flip_h = true
	player.sprite.play("side")
	await get_tree().create_timer(0.5).timeout
	player.direction = Vector2(-1, 0)
	player.sprite.flip_h = false
	player.direction = Vector2(0, 0)
	player.last_direction = 1
	await get_tree().create_timer(1).timeout
	player.scale.y += 0.1
	await get_tree().create_timer(0.1).timeout
	player.scale.y -= 0.1
	player.position = player.position.lerp(Vector2(player.position.x, player.position.y + 40), 0.2)
	await get_tree().create_timer(0.5).timeout
	camera.screen_shake(20, 10)
	blackout.play("fade out")
	await get_tree().create_timer(5).timeout
	get_tree().change_scene_to_packed(next_scene)
