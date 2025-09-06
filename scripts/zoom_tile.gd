extends Panel

@export var invisible: bool:
	set(value):
		invisible = value
		modulate.a = 1.0 - float(invisible)
@export var muted: bool = true:
	set(value):
		muted = value
		if muted:
			$MuteAndCamera/MuteIcon.show()
		else:
			$MuteAndCamera/MuteIcon.hide()
@export var cameraOff: bool = true:
	set(value):
		cameraOff = value
		if cameraOff:
			if is_node_ready():
				$CameraFootage.hide()
				$MuteAndCamera/CameraIcon.show()
			
		else:
			if is_node_ready():
				$CameraFootage.show()
				$MuteAndCamera/CameraIcon.hide()
@export var cameraImage: Texture2D:
	set(value):
		cameraImage = value
		if is_node_ready():
			$CameraFootage.texture = value
@export var firstName: String = "Joe":
	set(value):
		firstName = value
		if is_node_ready():
			$NameLabel.text = firstName + " " + lastName
			$InitialsLabel.text = firstName[0].to_upper() + lastName[0].to_upper()
@export var lastName: String = "Mama":
	set(value):
		lastName = value
		if is_node_ready():
			$NameLabel.text = firstName + " " + lastName
			$InitialsLabel.text = firstName[0].to_upper() + lastName[0].to_upper()
@export var talking: bool = false:
	set(value):
		talking = value
		if is_node_ready():
			$Talking.visible = talking
func importFromUser(user: Zoom.User):
	firstName = user.firstName
	lastName = user.lastName
	cameraImage = user.cameraImage
	cameraOff = user.cameraOff
	muted = user.muted
	if muted:
		talking = false
	else:
		talking = user.talking

func _ready() -> void:
	modulate.a = 1.0 - float(invisible)
	$NameLabel.text = firstName + " " + lastName
	$InitialsLabel.text = firstName[0].to_upper() + lastName[0].to_upper()
	$CameraFootage.texture = cameraImage
	if cameraOff:
		$MuteAndCamera/CameraIcon.show()
		$CameraFootage.hide()
	else:
		$CameraFootage.show()
		$MuteAndCamera/CameraIcon.hide()
	if muted:
		$MuteAndCamera/MuteIcon.show()
	else:
		$MuteAndCamera/MuteIcon.hide()
