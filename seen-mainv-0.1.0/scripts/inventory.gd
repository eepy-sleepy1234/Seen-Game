extends Sprite2D

@onready var item: Sprite2D = $Sprite2D
@onready var anim: AnimationPlayer = $Label/AnimationPlayer
signal throw()
func _ready() -> void:
	pass

func _process(delta: float) -> void:
		match Globals.inventory:
			"0":
				item.region_rect = Rect2(2.027, 5.948, 11.066, 5.229)
			"1":
				item.region_rect = Rect2(15.798, 0, 15.356, 16.249)
			"2":
				item.region_rect = Rect2(31.929, 0, 15.188, 15.914)
			"3":
				item.region_rect = Rect2(5.944, 22.879, 5.102, 4.198)
			"4":
				item.region_rect = Rect2(17.899, 19.968, 12.148, 8.999)
			_:
				item.region_rect = Rect2(0, 0, 0, 0)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact") and Globals.puzzle == 11 and Globals.inventory == "2":
		Globals.inventory = ""
		throw.emit()

func _on_item_first_inventory() -> void:
	anim.play("pickup")
	await get_tree().create_timer(2).timeout
	anim.play_backwards("pickup")
