extends Area2D
@onready var boss: AnimatedSprite2D = $".."

func _on_area_entered(area: Area2D) -> void:
	if fmod(boss.phase, 1.0) != 0.0:
		if boss.phase == 1.5:
			boss.phase += 0.5
		elif boss.phase == 2.5:
			boss.phase += 0.5
		else:
			pass
