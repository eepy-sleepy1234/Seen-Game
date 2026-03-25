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
	if new_text != "I should give this to the ghost up there first":
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
	Globals.listening = true

func open_box():
	open = true
	animation.play("open")

func close_box():
	textlabel.text = ""
	open = false
	animation.play("close")
