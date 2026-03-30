extends Node2D
@onready var blackout: AnimationPlayer = $CanvasLayer/blackout/AnimationPlayer
@onready var player: CharacterBody2D = %player
@onready var unlock: TileMapLayer = $unlock
@export var next_level: PackedScene
@export var keylevel = false
@export var door_unlocked = false
@onready var tiles: AnimationPlayer = $"Ghost Tiles/AnimationPlayer"
@onready var camera: AnimationPlayer = $"security camera/AnimationPlayer"
@onready var coll: AnimationPlayer = $Area2D/AnimationPlayer
var next = false
var invisible = false
@onready var off_timer: Timer = $"off timer"
@onready var on_timer: Timer = $"on timer"
@export var stairlevel = false
var itemScene = load("uid://dak20trdxfplt")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	blackout.play("start level")
	camera.play("go")
	Globals.listening = true
	loop_floor()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("drop") and Globals.inventory != "":
		var item_instance = itemScene.instantiate()
		item_instance.item_type = Globals.inventory
		item_instance.position = player.position
		if Globals.inventory == "1":
			player.is_ghost -= 1000
			player.box = false
		Globals.inventory = ""
		add_child(item_instance)
		if item_instance.item_type == 1:
			item_instance.get_box.connect(_on_item_get_box)
	if door_unlocked:
		unlock.visible = true
	else:
		unlock.visible = false
	if next:
		Globals.listening = false
		blackout.play("end level")
		await get_tree().create_timer(0.5).timeout
		Globals.puzzle += 1
		get_tree().change_scene_to_packed(next_level)
	
func loop_floor():
	while true:
		on_timer.start(randi_range(2, 5))
		await on_timer.timeout
		tiles.play("oh no")
		camera.play_backwards("go")
		coll.play_backwards("go")
		invisible = true
		off_timer.start()
		await off_timer.timeout
		tiles.play_backwards("oh no")
		camera.play("go")
		coll.play("go")
		invisible = false

func _on_item_get_box(ghost: bool) -> void:
	if Globals.inventory == "1":
		player.is_ghost += 1000
		if not ghost:
			player.box = true
		print(player.is_ghost)

func fall_through_floor():
	blackout.play("end level")
	await get_tree().create_timer(0.5).timeout
	blackout.play("start level")
	player.position = Vector2(5, -2)
	var item_instance = itemScene.instantiate()
	item_instance.item_type = 0
	item_instance.position = Vector2(-899, 62)
	if Globals.inventory != "":
		add_child(item_instance)
	Globals.inventory = ""

func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if invisible:
		fall_through_floor()
