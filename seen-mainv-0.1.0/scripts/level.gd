extends Node2D
@onready var blackout: AnimationPlayer = $CanvasLayer/blackout/AnimationPlayer
@onready var player: CharacterBody2D = %player
@onready var unlock: TileMapLayer = $unlock
@export var next_level: PackedScene
@export var keylevel = false
var door_unlocked = false
var next = false
@export var stairlevel = false
var itemScene = load("uid://dak20trdxfplt")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	blackout.play("start level")
	Globals.listening = true


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
		await get_tree().create_timer(2).timeout
		get_tree().change_scene_to_packed(next_level)


func _on_item_get_box(ghost: bool) -> void:
	if Globals.inventory == "1":
		player.is_ghost += 1000
		player.box = true
		print(player.is_ghost)
