extends Node2D
@onready var blackout: AnimationPlayer = $CanvasLayer/blackout/AnimationPlayer
@onready var player: CharacterBody2D = %player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	blackout.play("fade in")
	Globals.listening = true
	await get_tree().create_timer(0.1).timeout
	player.is_ghost = 0
