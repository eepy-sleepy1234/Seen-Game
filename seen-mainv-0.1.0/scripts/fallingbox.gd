extends Sprite2D
@onready var box: Sprite2D = $Sprite2D
var down = false
var go = false
signal damage()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if go:
		if box.global_position.y < global_position.y - 5:
			box.position.y += 2
		else:
			down = true
			await get_tree().create_timer(0.5).timeout
			down = false
			visible = false
			go = false

func startup():
	position = Vector2(randi_range(-124, 124), randi_range(-200, 10))
	visible = true
	go = true
	box.position.y = -170


func _on_area_2d_body_entered(body: Node2D) -> void:
	if down:
		if Globals.player_health > 1:
			Globals.player_health -= 1
			damage.emit()
		else:
			Globals.inventory = ""
			var _reload = get_tree().reload_current_scene()
