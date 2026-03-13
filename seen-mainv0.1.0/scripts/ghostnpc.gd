extends Node2D

@onready var collision: CollisionShape2D = $Area2D/CollisionShape2D
@onready var player: CharacterBody2D = $"../player"
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var textbox: MarginContainer = $"../CanvasLayer/textbox"


var player_in_range = false
@export var my_text = ""
@export var can_face_player = false
var open = false

func _process(delta: float) -> void:
	if player.is_ghost >= 0:
		sprite.visible = true
	else:
		sprite.visible = false
	if can_face_player:
		if player.position.x <= self.position.x:
			sprite.play("side")
		else:
			sprite.play("down")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if player.is_ghost >= 0:
		player_in_range = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	player_in_range = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact") and Globals.listening:
		if player_in_range and my_text != "":
			if not open:
				textbox.write_text(my_text)
				open = true
			else:
				textbox.close_box()
				open = false
