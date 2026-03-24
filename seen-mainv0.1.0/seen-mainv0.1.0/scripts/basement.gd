extends Node2D
@onready var blackout: AnimationPlayer = $CanvasLayer/blackout/AnimationPlayer
@onready var player: CharacterBody2D = %player
@onready var player_animation: AnimationPlayer = $player/AnimationPlayer
@onready var textbox: MarginContainer = $CanvasLayer/textbox

func wait_for_progress(target: int) -> void:
	while Globals.story_progress != target:
		await Globals.story_progress_changed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.story_progress = 9
	blackout.play("fade in")
	Globals.listening = false
	Globals.story_progress += 1
	player_animation.play("falling")
	await get_tree().create_timer(0.1).timeout
	player.is_ghost = 0
	await get_tree().create_timer(5).timeout
	Globals.listening = true
	Globals.story_progress += 1
	await wait_for_progress(12)
	#objective: walk through those boxes
	await wait_for_progress(13)
	textbox.write_text("Told you so")
	await get_tree().create_timer(3).timeout
	Globals.listening = true
	textbox.close_box()
	
