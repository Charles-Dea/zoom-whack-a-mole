extends LineEdit
func _on_text_submitted(text):
	print('_on_text_entered called')
	var pb=get_node('../ProgressBar')
	if text==get_node('..').str:
		pb.value-=25
		change_hacker_progress(-25)
		if pb.value<=0:
			get_node('..').queue_free()
	else:
		pb.value+=2
		change_hacker_progress(2)
func change_hacker_progress(v):
	pass
