extends Sprite2D
@onready var text: Label = $objectives
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var writesound = $AudioStreamPlayer
var new_page = false

func write(new_text):
	writesound.play()
	if new_page:
		for i in 20:
			text.visible_ratio -= 0.05
			await get_tree().create_timer(0.01).timeout
		text.text = ""
		new_page = false
	text.visible_ratio = 1
	for i in new_text:
		text.text += i
		await get_tree().create_timer(0.01).timeout
	new_page = true


func _on_panel_mouse_entered() -> void:
	anim.play("hover")


func _on_panel_mouse_exited() -> void:
	anim.play("unhover")
