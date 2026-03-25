extends MarginContainer
@onready var text: Label = $HBoxContainer/objectives


func write(new_text):
	for i in new_text:
		text.text += i
		await get_tree().create_timer(0.01).timeout
