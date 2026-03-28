extends Sprite2D
enum Items { key, box, ghost_box, gun, broken_camera }
var player_in_range = false
@export var item_type: Items

func _ready() -> void:
	match str(item_type):
		"0":
			self.region_rect = Rect2(2.027, 5.948, 11.066, 5.229)
		"1":
			self.region_rect = Rect2(15.798, 0, 15.356, 16.249)
		"2":
			self.region_rect = Rect2(31.929, 0, 15.188, 15.914)
		"3":
			self.region_rect = Rect2(5.944, 22.879, 5.102, 4.198)
		"4":
			self.region_rect = Rect2(17.899, 19.968, 12.148, 8.999)
		_:
			self.region_rect = Rect2(0, 0, 0, 0)
	

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and player_in_range:
		if Globals.inventory == "":
			Globals.inventory = str(item_type)
			self.queue_free()
			if Globals.inventory == "":
				pass
		else:
			pass
			#do a thing where it says no inventory space


func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	player_in_range = true


func _on_area_2d_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	player_in_range = false
