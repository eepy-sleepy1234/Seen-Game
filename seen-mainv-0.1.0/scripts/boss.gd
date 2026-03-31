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
var phase = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.inventory = "2"
	anim.play("float")
	enemy18.go = false
	enemy19.go = false
	enemy20.go = false
	enemy21.go = false
	phase1()
	await get_tree().create_timer(15).timeout
	phase = 1.5
	await get_tree().create_timer(8).timeout
	anim.play("fall")
	enemy18.anim.play("fade")
	enemy19.anim.play("fade")
	enemy20.anim.play("fade")
	enemy21.anim.play("fade")
	enemy18.go = false
	enemy19.go = false
	enemy20.go = false
	enemy21.go = false
	
func phase1():
	anim.play("attacking")
	while phase == 1:
		await get_tree().create_timer(1.4).timeout
		enemy1.startup()
		enemy2.startup()
		enemy3.startup()
		enemy4.startup()
		await get_tree().create_timer(1.4).timeout
		enemy5.startup()
		enemy6.startup()
		enemy7.startup()
		enemy8.startup()
		await get_tree().create_timer(1.4).timeout
		enemy9.startup()
		enemy10.startup()
		enemy11.startup()
		enemy12.startup()
		await get_tree().create_timer(1.4).timeout
		enemy13.startup()
		enemy14.startup()
		enemy15.startup()
		enemy16.startup()
		enemy17.startup()
		enemy18.anim.play("fade")
		enemy19.anim.play("fade")
		enemy20.anim.play("fade")
		enemy21.anim.play("fade")
		enemy18.go = false
		enemy19.go = false
		enemy20.go = false
		enemy21.go = false
		await get_tree().create_timer(1.4).timeout
		enemy18.startup()
		enemy19.startup()
		enemy20.startup()
		enemy21.startup()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
