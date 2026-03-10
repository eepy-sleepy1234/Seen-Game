extends Node2D

@onready var collision: CollisionShape2D = $Area2D/CollisionShape2D
@onready var player: CharacterBody2D = $"../player"
@onready var textbox: MarginContainer = $"../CanvasLayer/textbox"


@export var player_in_range = false
@export var my_text = ""
@export var open = false

func _ready() -> void:
	$Area2D.body_entered.connect(_on_area_2d_body_entered)
	await get_tree().create_timer(0.01).timeout
	player_in_range = false
	open = false

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact") and Globals.listening:
		if my_text != "" and player_in_range:
			if not open:
				textbox.write_text(my_text)
				open = true
			else:
				textbox.close_box()
				open = false

func _on_area_2d_body_entered(_body: Node2D) -> void:
	player_in_range = true

func _on_area_2d_body_exited(_body: Node2D) -> void:
	player_in_range = false
	if open:
		textbox.close_box()
		open = false
