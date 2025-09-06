extends Control

var user: Zoom.User

func _ready():
	position=get_local_mouse_position()
func _input(event):
	if event is InputEvent and event.is_pressed():
		var mp=get_local_mouse_position()
		if mp.x<0 or mp.x>128 or mp.y<0 or mp.y>93:queue_free()

func _on_mute_pressed() -> void:
	print("camera clicc")
	user.muted = true
	queue_free()

func _on_camera_pressed() -> void:
	print("camera clicc")
	user.cameraOff = true
	queue_free()

func _on_kick_pressed() -> void:
	print("kick clicc")
	var root = get_tree().current_scene
	root.user_list = root.user_list.filter(func (u): return u != user)
	print(root.user_list.map(func (u): return u.firstName +" " +u.lastName))
	root.update_zoom_tiles()
	queue_free()
