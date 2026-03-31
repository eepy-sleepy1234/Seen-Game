extends AnimatedSprite2D
@onready var camera_2d: Camera2D = $"../player/Camera2D"
@onready var color_rect: ColorRect = $"../CanvasLayer/ColorRect"
@onready var blackout: AnimationPlayer = $"../CanvasLayer/blackout/AnimationPlayer"
@onready var label: Label = $"../CanvasLayer/Label"
@onready var player: CharacterBody2D = %player
@onready var textbox: MarginContainer = $"../CanvasLayer/textbox"
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var enemy1: enemy = $"../bigright/enemy"
@onready var enemy2: enemy = $"../bigright/enemy2"
@onready var enemy3: enemy = $"../bigright/enemy3"
@onready var enemy4: enemy = $"../bigright/enemy4"
@onready var enemy5: enemy = $"../bigleft/enemy5"
@onready var enemy6: enemy = $"../bigleft/enemy6"
@onready var enemy7: enemy = $"../bigleft/enemy7"
@onready var enemy8: enemy = $"../bigleft/enemy8"
@onready var enemy9: enemy = $"../bigup/enemy9"
@onready var enemy10: enemy = $"../bigup/enemy10"
@onready var enemy11: enemy = $"../bigup/enemy11"
@onready var enemy12: enemy = $"../bigup/enemy12"
@onready var enemy13: enemy = $"../bigdown/enemy13"
@onready var enemy14: enemy = $"../bigdown/enemy14"
@onready var enemy15: enemy = $"../bigdown/enemy15"
@onready var enemy16: enemy = $"../bigdown/enemy16"
@onready var enemy17: enemy = $"../bigdown/enemy17"
@onready var enemy18: enemy = $"../small/enemy18"
@onready var enemy19: enemy = $"../small/enemy19"
@onready var enemy20: enemy = $"../small/enemy20"
@onready var enemy21: enemy = $"../small/enemy21"
@onready var fallingbox: Sprite2D = $"../fallingbox"
@onready var fallingbox2: Sprite2D = $"../fallingbox2"
@onready var fallingbox3: Sprite2D = $"../fallingbox3"
@onready var fallingbox4: Sprite2D = $"../fallingbox4"
@onready var fallingbox5: Sprite2D = $"../fallingbox5"

enum Phase { PHASE1, PHASE2, PHASE3, RESTING, WIN }
var current_phase: Phase = Phase.PHASE1
var boss_was_hit := false
var last_phase: Phase
const PHASE1_DURATION := 15.0
const PHASE2_DURATION := 15.0
const PHASE3_DURATION := 15.0
const REST_WINDOW := 5

func _ready() -> void:
	Globals.puzzle = 11
	Globals.inventory = "2"
	color_rect.color.a = 0
	player.last_direction = 1
	await get_tree().create_timer(0.01).timeout
	textbox.write_text("you think you can make fun of the segm and get away with it? Think again")
	await get_tree().create_timer(5).timeout
	textbox.close_box()
	label.text = "survive"
	anim.play("float")
	await get_tree().create_timer(1).timeout
	run_fight()
	
func run_fight() -> void:
	while current_phase != Phase.WIN:
		match current_phase:
			Phase.PHASE1:
				await run_phase(PHASE1_DURATION, phase1_attack)
			Phase.PHASE2:
				await run_phase(PHASE2_DURATION, phase2_attack)
			Phase.PHASE3:
				await run_phase(PHASE3_DURATION, phase3_attack)

func run_phase(duration: float, attack_func: Callable) -> void:
	anim.play("attacking")
	label.text = "survive"
	var timer := 0.0
	
	while timer < duration:
		attack_func.call()
		await get_tree().create_timer(1.4 * 5).timeout
		timer += 1.4 * 5
	last_phase = current_phase
	current_phase = Phase.RESTING
	await rest_window()

func rest_window() -> void:
	boss_was_hit = false
	anim.play("fall")
	label.text = "throw your box at \n the boss"
	hide_small_enemies()
	var elapsed := 0.0
	var interval := 0.1
	
	while elapsed < REST_WINDOW:
		await get_tree().create_timer(interval).timeout
		elapsed += interval
		if boss_was_hit:
			advance_phase()
			return
	if not boss_was_hit:
		current_phase = last_phase
	anim.play("float")

func advance_phase() -> void:
	match last_phase:
		Phase.PHASE1:
			current_phase = Phase.PHASE2
		Phase.PHASE2:
			current_phase = Phase.PHASE3
		Phase.PHASE3:
			current_phase = Phase.WIN
			win()

func win():
	hide_small_enemies()
	label.text = ""
	textbox.write_text("*drinks potion*")
	await get_tree().create_timer(3).timeout
	textbox.continue_text("I finally did it")
	blackout.play("fade out")

func hide_small_enemies():
	for e in [enemy18, enemy19, enemy20, enemy21]:
		if e.go:
			e.anim.play("fade")
			e.go = false

func phase1_attack():
	await get_tree().create_timer(1.4).timeout
	enemy1.startup(); enemy2.startup(); enemy3.startup(); enemy4.startup()
	await get_tree().create_timer(1.4).timeout
	enemy5.startup(); enemy6.startup(); enemy7.startup(); enemy8.startup()
	await get_tree().create_timer(1.4).timeout
	enemy9.startup(); enemy10.startup(); enemy11.startup(); enemy12.startup()
	await get_tree().create_timer(1.4).timeout
	enemy13.startup(); enemy14.startup(); enemy15.startup()
	enemy16.startup(); enemy17.startup()
	hide_small_enemies()
	await get_tree().create_timer(1.4).timeout
	enemy18.startup(); enemy19.startup(); enemy20.startup(); enemy21.startup()

func phase2_attack():
	await get_tree().create_timer(1.4).timeout
	enemy1.startup(); enemy2.startup(); enemy3.startup(); enemy4.startup()
	await get_tree().create_timer(1.4).timeout
	enemy5.startup(); enemy6.startup(); enemy7.startup(); enemy8.startup(); fallingbox.startup(); fallingbox2.startup(); fallingbox3.startup; fallingbox4.startup(); fallingbox5.startup()
	await get_tree().create_timer(1.4).timeout
	enemy9.startup(); enemy10.startup()
	await get_tree().create_timer(1.4).timeout
	enemy13.startup(); enemy14.startup(); enemy15.startup(); enemy11.startup(); enemy12.startup(); fallingbox.startup(); fallingbox2.startup(); fallingbox3.startup; fallingbox4.startup(); fallingbox5.startup()
	enemy16.startup(); enemy17.startup()
	hide_small_enemies()
	await get_tree().create_timer(1.4).timeout
	enemy18.startup(); enemy19.startup(); enemy20.startup(); enemy21.startup()
	
func phase3_attack():
	enemy1.speed = 3; enemy2.speed = 3; enemy3.speed = 3; enemy4.speed = 3; enemy5.speed = 3; enemy6.speed = 3; enemy7.speed = 3; enemy8.speed = 3; enemy9.speed = 3; enemy10.speed = 3; enemy11.speed = 3; enemy12.speed = 3; enemy13.speed = 3; enemy14.speed = 3; enemy15.speed = 3; enemy16.speed = 3; enemy17.speed = 3; enemy18.speed = 3; enemy19.speed = 3; enemy20.speed = 3; enemy21.speed = 3; 
	await get_tree().create_timer(1).timeout
	enemy1.startup(); enemy2.startup(); enemy3.startup(); enemy4.startup()
	await get_tree().create_timer(1).timeout
	enemy5.startup(); enemy6.startup(); enemy7.startup(); enemy8.startup()
	await get_tree().create_timer(1).timeout
	enemy9.startup(); enemy10.startup(); enemy11.startup(); enemy12.startup()
	await get_tree().create_timer(1).timeout
	enemy13.startup(); enemy14.startup(); enemy15.startup()
	enemy16.startup(); enemy17.startup()
	hide_small_enemies()
	await get_tree().create_timer(1).timeout
	enemy18.startup(); enemy19.startup(); enemy20.startup(); enemy21.startup()


func _on_enemy_damage() -> void:
	color_rect.color.a += 0.3
	camera_2d.screen_shake(20, 0.25)
