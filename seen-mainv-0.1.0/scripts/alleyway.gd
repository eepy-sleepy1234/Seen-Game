extends Node2D

@onready var textbox: MarginContainer = $CanvasLayer/textbox
@onready var objectives: MarginContainer = $CanvasLayer/objectivebox
@onready var blackout: AnimationPlayer = $CanvasLayer/blackout/AnimationPlayer
@onready var player: CharacterBody2D = $player
@onready var segm: AnimatedSprite2D = $"SEGM dude/AnimatedSprite2D"

func wait_for_progress(target: int) -> void:
	while Globals.story_progress != target:
		await Globals.story_progress_changed

func _ready() -> void:
	blackout.play("fade in")
	Globals.listening = true
	Globals.story_progress = 18
	if Globals.story_progress == 18:
		Globals.story_progress += 1
		await wait_for_progress(20)
		segm.animation = "sus"
		await wait_for_progress(21)
		segm.animation = "mad"
		await wait_for_progress(22)
		player.speed = 50
		player.direction = Vector2(0, -1)
		player.sprite.play("down_ghost")
		blackout.play("fade out")

func _process(delta: float) -> void:
	if player.position.y >= -120 and Globals.story_progress < 21:
		player.direction = Vector2(0, -1)
		Globals.listening = false
		textbox.write_text("I should give this to the ghost up there first")
		await get_tree().create_timer(0.2).timeout
		player.direction = Vector2(0, 0)
		player.last_direction = 3
		await get_tree().create_timer(3).timeout
		textbox.close_box()
		await get_tree().create_timer(0.4).timeout
		Globals.listening = true
