extends Area2D

var player_in_range = false
@onready var level: Node2D = $".."

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and (Globals.inventory == "0" or Globals.inventory2 == "0") and player_in_range:
		level.door_unlocked = true
		if Globals.inventory == "0":
			Globals.inventory = ""
		else:
			Globals.inventory2 = ""
	if player_in_range and level.door_unlocked:
		level.next = true

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	player_in_range = true

func _on_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	player_in_range = false
