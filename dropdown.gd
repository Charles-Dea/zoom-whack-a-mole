extends Control

var user: Zoom.User

func _ready():
	position=get_global_mouse_position()
func _input(event):
	if event is InputEvent and event.is_pressed():
		var mp=get_local_mouse_position()
		if mp.x<0 or mp.x>size.x or mp.y<0 or mp.y>size.y:queue_free()

func _on_mute_pressed() -> void:
	user.muted = true
	queue_free()

func _on_camera_pressed() -> void:
	user.cameraOff = true
	queue_free()

func _on_kick_pressed() -> void:
	var root = get_tree().current_scene
	root.user_list = root.user_list.filter(func (u): return u != user)
	root.update_zoom_tiles()
	queue_free()
