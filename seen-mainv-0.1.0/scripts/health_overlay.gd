extends CanvasModulate


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	color = Color.from_hsv(0, 0, 255, 1)



func _on_enemy_damage() -> void:
	visible = true
	color.s += 100
