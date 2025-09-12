extends Control

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://intro.tscn")


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://credits.tscn")


func _on_exit_pressed() -> void:
	if OS.has_feature("web"):
		JavaScriptBridge.eval("window.location.href='https://max-harold.itch.io/zoom-hacker-whacker'")
	else:
		get_tree().quit()
