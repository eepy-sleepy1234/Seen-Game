extends Area2D
@onready var light: PointLight2D = $PointLight2D
@onready var player: CharacterBody2D = %player



func _ready() -> void:
	light.visible = false

func _on_item_get_camera() -> void:
	light.visible = true
	player.has_camera = true


func _on_body_entered(body: Node2D) -> void:
	print("yeah get him")
