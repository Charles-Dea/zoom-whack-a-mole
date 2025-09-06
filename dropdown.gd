extends Control
func _ready():
	position=get_local_mouse_position()
func _input(event):
	if event is InputEvent and event.is_pressed():
		var mp=get_local_mouse_position()
		if mp.x<0 or mp.x>128 or mp.y<0 or mp.y>93:queue_free()
