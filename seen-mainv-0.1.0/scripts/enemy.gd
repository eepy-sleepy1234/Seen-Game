class_name enemy extends AnimatedSprite2D
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var player: CharacterBody2D = %player
@export var big: bool
@export var direction: int
@export var end: int
@export var speed = 2
@export var boss = false
var go = false
var startpos = Vector2(0.0, 0.0)
signal damage()
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
	await get_tree().create_timer(0.01).timeout

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if big:
		if direction == 1 and go:
			if position.y > end:
				position.y -= speed
			else:
				anim.play("fade")
				go = false
		if direction == 2 and go:
			if position.x < end:
				position.x += speed
			else:
				anim.play("fade")
				go = false
		if direction == 3 and go:
			if position.y < end:
				position.y += speed
			else:
				anim.play("fade")
				go = false
		if direction == 4 and go:
			if position.x > end:
				position.x -= speed
			else:
				anim.play("fade")
				go = false
	else:
		if self.position.x - player.position.x < -1.5:
			play("small side")
			flip_h = true
			position.x += 0.25 * speed
		elif self.position.x - player.position.x > 1.5:
			play("small side")
			flip_h = false
			position.x -= 0.25 * speed
		if self.position.y - player.position.y < -1.5:
			play("small down")
			position.y += 0.25 * speed
		elif self.position.y - player.position.y > 1.5:
			play("small up")
			position.y -= 0.25 * speed

func startup():
	go = true
	position = startpos
	anim.play("RESET")
	visible = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if go:
		if boss:
			if Globals.player_health > 1:
				Globals.player_health -= 1
				damage.emit()
			else:
				Globals.inventory = ""
				var _reload = get_tree().reload_current_scene()
		else:
			Globals.inventory = ""
			var _reload = get_tree().reload_current_scene()
