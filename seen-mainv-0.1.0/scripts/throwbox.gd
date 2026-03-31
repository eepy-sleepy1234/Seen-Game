extends Sprite2D
@onready var player: CharacterBody2D = %player
@onready var boss_room: Node2D = $".."
@onready var boss: AnimatedSprite2D = $"../boss"
var direction = 0
var distance = 0
var itemScene = load("uid://dak20trdxfplt")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if direction == 1:
		if position.y > -240:
			position.y -= 3
		distance -= 1
	if direction == 2:
		if position.x < 145:
			position.x += 3
		distance -= 1
	if direction == 3:
		if position.y < 0:
			position.y += 3
		distance -= 1
	if direction == 4:
		if position.x > -145:
			position.x -= 3
		distance -= 1
	if distance == 0:
		visible = false
		var item_instance = itemScene.instantiate()
		item_instance.item_type = "2"
		item_instance.position = position
		boss_room.add_child(item_instance)


func _on_inventory_throw() -> void:
	position = player.position
	direction = player.last_direction
	distance = 20
	visible = true

func _on_area_2d_area_entered(area: Area2D) -> void:
	if boss.current_phase == boss.Phase.RESTING:
		direction = 3
		distance = 15
		boss.boss_was_hit = true
