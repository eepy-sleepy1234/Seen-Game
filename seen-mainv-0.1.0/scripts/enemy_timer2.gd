extends Node2D

@onready var enemy: AnimatedSprite2D = $"../enemy"

func _ready() -> void:
	await get_tree().create_timer(1).timeout
	enemy.startup()
