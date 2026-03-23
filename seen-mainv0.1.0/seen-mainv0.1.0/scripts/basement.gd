extends Node2D
@onready var blackout: AnimationPlayer = $CanvasLayer/blackout/AnimationPlayer
@onready var player: CharacterBody2D = %player
@onready var player_animation: AnimationPlayer = $player/AnimationPlayer

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
