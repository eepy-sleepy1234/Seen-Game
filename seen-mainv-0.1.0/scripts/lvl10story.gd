extends Node2D
@onready var textbox: MarginContainer = $"../CanvasLayer/textbox"
@onready var player: CharacterBody2D = %player
@onready var box: Sprite2D = $"../box"
@onready var ghost_wall: TileMapLayer = $"../Ghost Wall"
@onready var node_2d: Node2D = $".."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_gun_get_gun() -> void:
	Globals.listening = false
	player.direction = Vector2(0, 0)
	textbox.write_text("The only way I can get out of here is to become a ghost")
	await get_tree().create_timer(4).timeout
	textbox.close_box()
	player.direction = Vector2(0, -1)
	await get_tree().create_timer(0.35).timeout
	player.direction = Vector2(-1, 0)
	await get_tree().create_timer(0.7).timeout
	player.direction = Vector2(0, 0)
	await get_tree().create_timer(0.2).timeout
	box.item_type = "2"
	box.region_rect = Rect2(31.929, 0, 15.188, 15.914)
	Globals.inventory = ""
	Globals.listening = true



func _on_box_get_box(ghost: bool) -> void:
	if ghost:
		ghost_wall.visible = false
		node_2d.door_unlocked = true
