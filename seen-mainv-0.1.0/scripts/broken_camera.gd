extends Area2D
@onready var light: PointLight2D = $PointLight2D
@onready var player: CharacterBody2D = %player



func _ready() -> void:
	light.visible = false

func _on_item_get_camera() -> void:
	light.visible = true
	player.has_camera = true

func _on_area_entered(area: Area2D) -> void:
	var parent = area.get_parent()
	if parent is enemy and player.has_camera:
		parent.position = parent.startpos
		parent.anim.play("RESET")
		parent.go = false
		parent.visible = false
