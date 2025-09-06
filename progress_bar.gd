extends ProgressBar
func _process(delta):
	value+=delta*100/60
	if value>=100:get_tree().change_scene_to_file('res://GameOver.tscn')
