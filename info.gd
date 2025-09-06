extends Button
func _pressed():
	var box=get_node('./Box')
	box.visible=!box.visible
