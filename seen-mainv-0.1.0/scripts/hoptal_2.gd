extends Node2D
@onready var textbox: MarginContainer = $CanvasLayer/textbox
@onready var blackout: AnimationPlayer = $CanvasLayer/blackout/AnimationPlayer
@onready var player: CharacterBody2D = $player
@onready var bed: AnimatedSprite2D = $bed
@onready var haha: Node2D = $haha
@onready var ghost_particles: CPUParticles2D = $"bed/ghost particles"
@onready var bedanim: AnimationPlayer = $bedanim
@onready var nurse: AnimationPlayer = $nurse/AnimationPlayer
var next_scene: PackedScene = load("uid://dd65bmg1sswdc")

func wait_for_progress(target: int) -> void:
	while Globals.story_progress != target:
		await Globals.story_progress_changed

func _ready() -> void:
	blackout.play("fade in")
	Globals.story_progress += 1
	Globals.listening = false
	player.sprite.play("up")
	await get_tree().create_timer(2).timeout
	textbox.continue_text("you should get back in bed")
	await get_tree().create_timer(2).timeout
	textbox.continue_text("you really can't be wandering off like that")
	await get_tree().create_timer(2).timeout
	textbox.close_box()
	await wait_for_progress(28)
	Globals.listening = false
	player.visible = false
	bed.play("not ghost")
	await get_tree().create_timer(1).timeout
	textbox.write_text("I will go get the doctor now")
	await get_tree().create_timer(5).timeout
	textbox.close_box()
	nurse.play("move")
	await get_tree().create_timer(0.75).timeout
	bedanim.play("falling")
	ghost_particles.emitting = true
	await get_tree().create_timer(0.25).timeout
	blackout.play("fade out")
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_packed(next_scene)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if haha.player_in_range:
		player.direction = Vector2(0, -1)
		Globals.listening = false
		textbox.write_text("don't walk out on her like that")
		await get_tree().create_timer(0.1).timeout
		player.direction = Vector2(0, 0)
		player.last_direction = 3
		await get_tree().create_timer(3).timeout
		textbox.close_box()
		Globals.listening = true
