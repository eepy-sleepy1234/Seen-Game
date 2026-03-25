extends Node2D

@onready var collision: CollisionShape2D = $Area2D/CollisionShape2D
@onready var player: CharacterBody2D = $"../player"
@onready var textbox: MarginContainer = $"../CanvasLayer/textbox"

@export var my_progress = 0
@export var interactable = false
@export var player_in_range = false
@export var my_text = ""
@export var open = false
@export var story = false

func _ready() -> void:
	await get_tree().create_timer(0.01).timeout
	player_in_range = false
	open = false

func _process(delta: float) -> void:
	if story:
		if Globals.listening and Globals.story_progress == my_progress and (not interactable) and player_in_range:
			Globals.story_progress += 1
			Globals.listening = false
			player.direction = Vector2(0, 0)

func _input(_event: InputEvent) -> void:
	if story:
			if Input.is_action_just_pressed("interact") and Globals.listening and player_in_range:
				if Globals.story_progress == my_progress and interactable:
					Globals.story_progress += 1
					Globals.listening = false
					player.direction = Vector2(0, 0)
	else:
		if Input.is_action_just_pressed("interact") and Globals.listening:
			if my_text != "" and player_in_range:
				if not open:
					if Globals.story_progress == 3:
						my_text = "now is not the time"
					textbox.write_text(my_text)
					open = true
				else:
					textbox.close_box()
					open = false

func _on_area_2d_body_entered(_body: Node2D) -> void:
	player_in_range = true

func _on_area_2d_body_exited(_body: Node2D) -> void:
	player_in_range = false
	if open and not story:
		textbox.close_box()
		open = false
