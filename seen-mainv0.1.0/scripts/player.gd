extends CharacterBody2D
@onready var particles: CPUParticles2D = $"not ghost particles"
@onready var ghost_particles: CPUParticles2D = $"ghost particles"

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
var speed = 100
var last_direction = 0
@export var is_ghost = 0
var prev_ghost_state = 0
var direction = Vector2(0, 0)

func _ready() -> void:
	is_ghost = 0
	prev_ghost_state = 0
	await get_tree().create_timer(0.01).timeout
	is_ghost = 0
	prev_ghost_state = 0

func _physics_process(_delta):
	if Globals.listening:
		direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if is_ghost >= 0:
		set_collision_mask_value(2, true)
		set_collision_mask_value(1, false)
		set_collision_layer_value(2, true)
		set_collision_layer_value(1, false)
		modulate.a = 0.82
	else:
		set_collision_mask_value(1, true)
		set_collision_mask_value(2, false)
		set_collision_layer_value(1, true)
		set_collision_layer_value(2, false)
		modulate.a = 1
		
	if direction.x > 0:
		sprite.flip_h = true
		last_direction = 2
		if is_ghost >= 0:
			sprite.play("side_ghost")
		else:
			sprite.play("side")
	elif direction.x < 0:
		sprite.flip_h = false
		last_direction = 4
		if is_ghost >= 0:
			sprite.play("side_ghost")
		else:
			sprite.play("side")
	elif direction.y < 0:
		last_direction = 1
		if is_ghost >= 0:
			sprite.play("up_ghost")
		else:
			sprite.play("up")
	elif direction.y > 0:
		last_direction = 3
		if is_ghost >= 0:
			sprite.play("down_ghost")
		else:
			sprite.play("down")
	else:
		if is_ghost >= 0:
			if last_direction == 1:
				sprite.play("idle_ghost_up")
			elif last_direction == 3:
				sprite.play("idle_ghost")
			elif last_direction == 2:
				sprite.play("idle_ghost_side")
			elif last_direction == 4:
				sprite.play("idle_ghost_side")
			else:
				sprite.play("idle_ghost")
		else:
			if last_direction == 1:
				sprite.play("idle_up")
			elif last_direction == 3:
				sprite.play("idle")
			elif last_direction == 2:
				sprite.play("idle_side")
			elif last_direction == 4:
				sprite.play("idle_side")
			else:
				sprite.play("idle")
	if prev_ghost_state < 0 and is_ghost >= 0:
		ghost_particles.emitting = true
	elif prev_ghost_state >= 0 and is_ghost < 0:
		particles.emitting = true
	prev_ghost_state = is_ghost
	
	direction = direction.normalized()
	velocity = (direction * speed)
	move_and_slide()
