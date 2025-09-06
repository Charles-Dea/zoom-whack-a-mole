extends Button
@export var dropdown=null
func _pressed():
	print(dropdown)
	if dropdown==null:
		dropdown=preload('res://Dropdown.tscn').instantiate()
		add_child(dropdown)
	else:
		dropdown.queue_free()
		dropdown=null
