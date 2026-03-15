extends Node2D

@onready var player: CharacterBody2D = $"../player"
@onready var textbox: MarginContainer = $"../CanvasLayer/textbox"
@onready var area: Area2D = $Area2D
@export var yes = false
var player_in_range = false
@export var my_text = ""

func _ready() -> void:
	area.body_entered.connect(_on_area_2d_body_entered)
	area.body_exited.connect(_on_area_2d_body_exited)
	area.set_collision_mask_value(2, true)
	area.set_collision_mask_value(1, true)
	area.set_collision_layer_value(2, true)
	area.set_collision_layer_value(1, true)

func _on_area_2d_body_entered(_body: Node2D) -> void:
	player_in_range = true
	player.is_ghost -= 1

func _on_area_2d_body_exited(_body: Node2D) -> void:
	player_in_range = false
	player.is_ghost += 1

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact") and player_in_range and my_text != "" and Globals.listening:
		if not textbox.open:
			textbox.write_text(my_text)
		else:
			textbox.close_box()
