extends Sprite2D
@onready var player: CharacterBody2D = %player
var direction = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if direction == 1:
		position.y -= 3
	if direction == 2:
		position.x += 3
	if direction == 3:
		position.y += 3
	if direction == 4:
		position.x -= 3


func _on_inventory_throw() -> void:
	position = player.position
	direction = player.last_direction
	visible = true
