extends MarginContainer

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var textlabel: Label = $"../textbox/MarginContainer/HBoxContainer/Label"

var open = false
var tween = create_tween()

func write_text(new_text) -> void:
	Globals.listening = false
	textlabel.text = new_text
	open_box()
	if tween:
		tween.kill()
	textlabel.visible_ratio = 0.0
	await get_tree().create_timer(0.5).timeout
	tween = create_tween()
	tween.tween_property(textlabel, "visible_ratio", 1, len(textlabel.text) * 0.05)
	await tween.finished
	if new_text not in ["I should give this to the ghost up there first", "phew, that was a close one", "don't walk out on her like that", "Why can I walk through everything besides these stairs?"]:
		Globals.listening = true

func continue_text(new_text) -> void:
	Globals.listening = false
	textlabel.text = new_text
	if not open:
		open_box()
	if tween:
		tween.kill()
	textlabel.visible_ratio = 0.0
	await get_tree().create_timer(0.5).timeout
	tween = create_tween()
	tween.tween_property(textlabel, "visible_ratio", 1, len(textlabel.text) * 0.01)
	await tween.finished
	if new_text not in ["you should get back in bed", "and why can I talk to people and ghosts?"]:
		Globals.listening = true

func open_box():
	open = true
	animation.play("open")

func close_box():
	textlabel.text = ""
	open = false
	animation.play("close")
