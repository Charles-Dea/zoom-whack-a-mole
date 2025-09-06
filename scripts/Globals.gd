extends Node

func load_image(image_name: String="wakeup"):
	return load("res://img/pfp/"+image_name+".jpg")
	
func get_zoom_tile(row: int, col: int):
	var node_name = "Tile"+str(col)+str(row)
	for node in get_tree().get_nodes_in_group("zoom_tile"):
		if node.name == node_name:
			return node
	return null

func empty_zoom_tile_at(row: int, col: int):
	get_zoom_tile(row, col).invisible = true

func empty_all_zoom_tiles():
	for row in range(1,6):
		for col in range(1,6):
			empty_zoom_tile_at(row,col)

func show_zoom_tile_at(row: int, col: int):
	get_zoom_tile(row, col).invisible = false

func show_zoom_tiles(users: Array[Zoom.User]):
	for user in users:
		show_zoom_tile_at(user.row, user.col)
