extends Node2D

@onready var collision: CollisionShape2D = $Area2D/CollisionShape2D
@onready var player: CharacterBody2D = $"../player"


@export var player_in_range = false
@export var my_progress = 0

func _ready() -> void:
	$Area2D.body_entered.connect(_on_area_2d_body_entered)
	await get_tree().create_timer(0.01).timeout
	player_in_range = false

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact") and Globals.listening and player_in_range:
		if Globals.story_progress == my_progress:
			Globals.story_progress += 1
			Globals.listening = false
			player.direction = Vector2(0, 0)

func _on_area_2d_body_entered(_body: Node2D) -> void:
	player_in_range = true

func _on_area_2d_body_exited(_body: Node2D) -> void:
	player_in_range = false
