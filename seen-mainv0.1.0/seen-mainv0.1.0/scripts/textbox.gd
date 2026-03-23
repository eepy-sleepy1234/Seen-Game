extends MarginContainer

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var textlabel: Label = $"../textbox/MarginContainer/HBoxContainer/Label"

var text = ""
var open = false

func _ready() -> void:
	pass # Replace with function body.

func write_text(new_text) -> void:
	textlabel.text = ""
	text = new_text
	open_box()
	await get_tree().create_timer(0.5).timeout
	type_words()

func continue_text(new_text) -> void:
	textlabel.text = ""
	text = new_text
	if not open:
		open_box()
	await get_tree().create_timer(0.5).timeout
	type_words()

func open_box():
	animation.play("open")
	open = true
func close_box():
	animation.play("close")
	open = false

func type_words():
	if text != "":
		for i in text:
			if Input.is_action_pressed("interact"):
				break
			if not open:
				break
			textlabel.text += i
			if i != ".":
				await get_tree().create_timer(0.05).timeout
			elif i == " ":
				await get_tree().create_timer(0.01).timeout
			else:
				await get_tree().create_timer(0.2).timeout
