extends AnimatedSprite2D
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

enum Phase { PHASE1, PHASE2, PHASE3, RESTING, WIN }
var current_phase: Phase = Phase.PHASE1
var boss_was_hit := false

const PHASE1_DURATION := 15.0
const PHASE2_DURATION := 15.0
const PHASE3_DURATION := 15.0
const REST_WINDOW := 5

func _ready() -> void:
	Globals.puzzle = 11
	Globals.inventory = "2"
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
	var timer := 0.0
	
	while timer < duration:
		attack_func.call()
		await get_tree().create_timer(1.4 * 5).timeout
		timer += 1.4 * 5
	await rest_window()

func rest_window() -> void:
	boss_was_hit = false
	anim.play("fall")
	hide_small_enemies()
	var elapsed := 0.0
	var interval := 0.1
	
	while elapsed < REST_WINDOW:
		await get_tree().create_timer(interval).timeout
		elapsed += interval
		if boss_was_hit:
			advance_phase()
			return
	anim.play("float")

func advance_phase() -> void:
	match current_phase:
		Phase.PHASE1:
			current_phase = Phase.PHASE2
		Phase.PHASE2:
			current_phase = Phase.PHASE3
		Phase.PHASE3:
			current_phase = Phase.WIN
			win()

func win():
	pass

func hide_small_enemies():
	for e in [enemy18, enemy19, enemy20, enemy21]:
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
	pass
	
func phase3_attack():
	pass
