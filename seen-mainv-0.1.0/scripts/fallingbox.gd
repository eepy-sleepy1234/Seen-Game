extends Sprite2D
@onready var box: Sprite2D = $Sprite2D
var down = false
var go = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	startup()


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


func _on_area_2d_body_entered(body: Node2D) -> void:
	if down:
		Globals.inventory = ""
		var _reload = get_tree().reload_current_scene()
