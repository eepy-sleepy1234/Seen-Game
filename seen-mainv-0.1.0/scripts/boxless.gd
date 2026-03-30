extends Area2D

@onready var textbox: MarginContainer = $"../CanvasLayer/textbox"
@onready var player: CharacterBody2D = %player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if Globals.inventory == "1":
		player.direction = Vector2(0, 0)
		textbox.write_text("I don't need this anymore")
		Globals.inventory = ""
		await get_tree().create_timer(2).timeout
		textbox.close_box()
	elif Globals.inventory2 == "1":
		player.direction = Vector2(0, 0)
		textbox.write_text("I don't need this anymore")
		Globals.inventory2 = ""
		await get_tree().create_timer(2).timeout
		textbox.close_box()
