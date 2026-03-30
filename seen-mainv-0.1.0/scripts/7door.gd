extends Area2D
@onready var textbox: MarginContainer = $"../CanvasLayer/textbox"
@onready var blackout: AnimationPlayer = $"../CanvasLayer/blackout/AnimationPlayer"

@export var number: int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Globals.count7 == 5:
		textbox.write_text("This is taking forever I should go back")
		await get_tree().create_timer(4).timeout
		textbox.close_box()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if number == 5:
		if Globals.count7 == 5:
			blackout.play("end level")
			await get_tree().create_timer(0.5).timeout
			get_tree().change_scene_to_packed(load("res://scenes/puzzle_8.tscn"))
			pass
		else:
			blackout.play("end level")
			await get_tree().create_timer(0.5).timeout
			Globals.count7 = 1
			get_tree().change_scene_to_packed(load("res://scenes/puzzle_6.tscn"))
			pass
	if number == Globals.count7:
		Globals.count7 += 1
	if number != 5:
		blackout.play("end level")
		await get_tree().create_timer(0.5).timeout
		var _reload = get_tree().reload_current_scene()
