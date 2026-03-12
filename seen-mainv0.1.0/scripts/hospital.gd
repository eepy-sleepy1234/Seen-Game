extends Node2D
@onready var guy: AnimatedSprite2D = $guy
@onready var blackout_animation: AnimationPlayer = $CanvasLayer/blackout/AnimationPlayer
@onready var nurse: AnimatedSprite2D = $nurse
@onready var nurse_animation: AnimationPlayer = $nurse/AnimationPlayer
@onready var textbox: MarginContainer = $CanvasLayer/textbox
@onready var ghost_particles: CPUParticles2D = $"guy/ghost particles"


func _ready() -> void:
	blackout_animation.play("fade in")
	guy.play("eepy")
	nurse_animation.play("movement")
	await get_tree().create_timer(4).timeout
	guy.play("wake up")
	await get_tree().create_timer(2.5).timeout
	textbox.write_text("Oh, you're finally awake. Let me get a doctor for you.")
	await get_tree().create_timer(5.5).timeout
	textbox.close_box()
	guy.play("ghost")
	ghost_particles.emitting = true
	await get_tree().create_timer(1).timeout
	guy.play("falling repeat")
	await get_tree().create_timer(0.5).timeout
	guy.play("falling done")
	blackout_animation.play("fade out")
