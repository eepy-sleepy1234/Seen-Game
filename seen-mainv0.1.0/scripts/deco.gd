extends Sprite2D
@onready var player: CharacterBody2D = $"../../player"
@export var size = 0
@onready var sprite: Sprite2D = $"."

func _process(delta: float) -> void:
	if player.position.distance_to(self.position) < size and player.is_ghost >= 0:
		if sprite.modulate.a >= 0.4:
			sprite.modulate.a -= 0.05
	else:
		if sprite.modulate.a <= 1:
			sprite.modulate.a += 0.05
