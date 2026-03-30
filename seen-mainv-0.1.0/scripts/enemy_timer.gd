extends Node2D

@onready var enemy: AnimatedSprite2D = $"../enemy"
@onready var enemy3: AnimatedSprite2D = $"../enemy3"
@onready var enemy4: AnimatedSprite2D = $"../enemy4"
@onready var enemy5: AnimatedSprite2D = $"../enemy5"
@onready var enemy6: AnimatedSprite2D = $"../enemy6"
@onready var enemy2: AnimatedSprite2D = $"../enemy2"
@onready var enemy7: AnimatedSprite2D = $"../enemy7"
@onready var enemy8: AnimatedSprite2D = $"../enemy8"
@onready var enemy9: AnimatedSprite2D = $"../enemy9"
@onready var enemy10: AnimatedSprite2D = $"../enemy10"
@onready var enemy11: AnimatedSprite2D = $"../enemy11"
@onready var enemy12: AnimatedSprite2D = $"../enemy12"
@onready var enemy13: AnimatedSprite2D = $"../enemy13"
@onready var enemy14: AnimatedSprite2D = $"../enemy14"
@onready var enemy15: AnimatedSprite2D = $"../enemy15"
@onready var enemy16: AnimatedSprite2D = $"../enemy16"
@onready var enemy17: AnimatedSprite2D = $"../enemy17"
@onready var enemy18: AnimatedSprite2D = $"../enemy18"


func _ready() -> void:
	loop()

func loop():
	while true:
		enemy.startup()
		enemy3.startup()
		enemy4.startup()
		enemy5.startup()
		enemy6.startup()
		await get_tree().create_timer(4).timeout
		enemy2.startup()
		enemy7.startup()
		enemy8.startup()
		enemy9.startup()
		enemy10.startup()
		enemy11.startup()
		enemy12.startup()
		enemy13.startup()
		enemy14.startup()
		enemy15.startup()
		enemy16.startup()
		enemy17.startup()
		enemy18.startup()
		await get_tree().create_timer(3).timeout
