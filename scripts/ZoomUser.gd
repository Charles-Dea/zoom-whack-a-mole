extends Node
class User:
	var firstName: String="Joe": 
		set(value):
			firstName = value
			updateZoomTile()
	var lastName: String="Mama":
		set(value):
			lastName = value
			updateZoomTile()
	var cameraOff: bool=true:
		set(value):
			cameraOff = value
			updateZoomTile()
	var muted: bool=true:
		set(value):
			muted = value
			updateZoomTile()
	var cameraImage: Texture2D=Globals.load_image("wakeup"):
		set(value):
			cameraImage = value
			updateZoomTile()
	var row: int = -1:
		set(value):
			if valid_coords():
				Globals.empty_zoom_tile_at(row, col)
				row = value
				updateZoomTile()
				Globals.show_zoom_tile_at(row, col)
			else:
				row = value
	var col: int = -1:
		set(value):
			if valid_coords():
				Globals.empty_zoom_tile_at(row, col)
				col = value
				updateZoomTile()
				Globals.show_zoom_tile_at(row, col)
			else:
				col = value
	var page: int = -1:
		set(value):
			page = value
	
	func get_zoom_tile():
		return Globals.get_zoom_tile(row, col)
	
	func valid_coords() -> bool:
		return row >= 1 and row <= 5 and col >= 1 and col <= 5
	
	func updateZoomTile():
		get_zoom_tile().importFromUser(self)
		
	func _init(firstName: String="Joe", lastName: String="Mama", cameraOff: bool=true, muted: bool=true, cameraImage: Texture2D=Globals.load_image("wakeup"), row: int = 1, col: int = 1, page: int = 1):
		self.row = row
		self.col = col
		self.page = page
		self.firstName = firstName
		self.lastName = lastName
		self.cameraOff = cameraOff
		self.muted = muted
		self.cameraImage = cameraImage
		
