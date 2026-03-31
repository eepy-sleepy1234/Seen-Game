extends Area2D

@onready var camera: Node2D = $"../camera"
@onready var sprite_2d: Sprite2D = $"../Sprite2D"
@onready var animation_player: AnimationPlayer = $"../camera/AnimationPlayer"
@onready var point_light_2d: PointLight2D = $"../PointLight2D"
@onready var player: CharacterBody2D = %player
@onready var ghost_tiles: TileMapLayer = $"../Ghost Tiles"
@onready var player_light: PointLight2D = $"../player/PointLight2D"
@onready var anim: AnimationPlayer = $"../Area2D2/AnimationPlayer"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("RESET")
	sprite_2d.visible = false
	ghost_tiles.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	sprite_2d.visible = true
	animation_player.play("new_animation")
	anim.play("new_animation")
	var parent = area.get_parent()
	parent.queue_free()
	point_light_2d.queue_free()
	player_light.queue_free()
	player.is_ghost = -1
	ghost_tiles.visible = true
