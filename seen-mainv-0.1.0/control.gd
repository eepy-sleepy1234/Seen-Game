extends Control

@onready var credits = $RichTextLabel

var speed = 50  # pixels per second

func _process(delta):
	credits.position.y -= speed * delta
