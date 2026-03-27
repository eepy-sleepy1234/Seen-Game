extends Node2D

@onready var collision: CollisionShape2D = $Area2D/CollisionShape2D
@onready var player: CharacterBody2D = $"../player"
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var textbox: MarginContainer = $"../CanvasLayer/textbox"
@onready var area: Area2D = $Area2D

var player_in_range = false
@export var my_text = ""
@export var can_face_player = false
var open = false
@export var dialogue: Array[String] = [""]
@export var dialogue_progress: Array[int] = [0]
func _process(delta: float) -> void:
	if player.is_ghost >= 0:
		sprite.visible = true
	else:
		sprite.visible = false
	if can_face_player:
		if abs(player.position.y - position.y) <= abs(player.position.x - position.x):
			sprite.play("side")
		else:
			sprite.play("down")

func _ready() -> void:
	area.area_entered.connect(_on_area_2d_body_entered)
	area.area_exited.connect(_on_area_2d_body_exited)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if player.is_ghost >= 0:
		player_in_range = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	player_in_range = false
	if open:
		textbox.close_box()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact") and Globals.listening:
		if player_in_range and my_text != "":
			if not open:
				if len(dialogue) > 0:
					if dialogue_progress[0] == 0:
						dialogue_progress.pop_front()
						my_text = dialogue.pop_front()
					else:
						if Globals.story_progress == dialogue_progress[0]:
							dialogue_progress.pop_front()
							my_text = dialogue.pop_front()
							Globals.story_progress += 1
				textbox.write_text(my_text)
				open = true
			else:
				if len(dialogue) <= 0:
					textbox.close_box()
					open = false
				else:
					if dialogue_progress[0] == 0:
						my_text = dialogue.pop_front()
						dialogue_progress.pop_front()
						textbox.continue_text(my_text)
					else:
						if Globals.story_progress == dialogue_progress[0]:
							dialogue_progress.pop_front()
							my_text = dialogue.pop_front()
							Globals.story_progress += 1
							textbox.continue_text(my_text)
						else:
							textbox.close_box()
							open = false
