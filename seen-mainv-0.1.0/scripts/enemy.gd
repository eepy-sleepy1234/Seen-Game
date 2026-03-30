extends AnimatedSprite2D
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var player: CharacterBody2D = %player

@export var big: bool
@export var direction: int
@export var end: int
var go = false
var startpos = Vector2(0.0, 0.0)
func _ready() -> void:
	startpos = position
	anim.play("fade")
	if big:
		play("big")
		rotation_degrees = 0.0
		if direction == 3:
			rotation_degrees = 180.0
		if direction == 2:
			rotation_degrees = 90.0
		if direction == 4:
			rotation_degrees = -90.0
	else:
		play("small down")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if big:
		if direction == 1 and go:
			if position.y > end:
				position.y -= 2
			else:
				anim.play("fade")
				go = false
		if direction == 2 and go:
			if position.x < end:
				position.x += 2
			else:
				anim.play("fade")
				go = false
		if direction == 3 and go:
			if position.y < end:
				position.y += 2
			else:
				anim.play("fade")
				go = false
		if direction == 4 and go:
			if position.x > end:
				position.x -= 2
			else:
				anim.play("fade")
				go = false
	else:
		if position.x - player.position.x < 1:
			play("small side")
			flip_h = true
			position.x += 1
		elif position.x - player.position.x > 1:
			play("small side")
			position.x -= 1
		elif position.y - player.position.y < 1:
			play("small down")
			position.y += 1
		elif position.y - player.position.y > 1:
			play("small up")
			position.y -= 1

func startup():
	go = true
	position = startpos
	anim.play("RESET")


func _on_area_2d_body_entered(body: Node2D) -> void:
	Globals.inventory = ""
	var _reload = get_tree().reload_current_scene()


func _on_area_2d_2_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	position = startpos
	anim.play("RESET")
	print("ow")
