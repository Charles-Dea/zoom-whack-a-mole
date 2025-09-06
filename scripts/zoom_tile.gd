extends Panel

var dropdown

@onready var initialsLabel: Label = $Initial/InitialsLabel
@onready var nameLabel: Label = $Stack/NameLabel
@onready var muteIcon: TextureRect = $Stack/MuteAndCamera/MuteIcon
@onready var cameraIcon: TextureRect = $Stack/MuteAndCamera/CameraIcon
@onready var cameraFootage: TextureRect = $CameraFootage
@onready var deathProgressBar: ProgressBar = $CameraFootage/DeathProgressBar
@onready var talkingPanel: Panel = $Talking

var tileUser: Zoom.User
@export var invisible: bool = true:
	set(value):
		invisible = value
		modulate.a = 1.0 - float(invisible)
@export var muted: bool = true:
	set(value):
		muted = value
		if muted:
			muteIcon.show()
		else:
			muteIcon.hide()
@export var cameraOff: bool = true:
	set(value):
		cameraOff = value
		if cameraOff:
			if is_node_ready():
				cameraFootage.hide()
				cameraIcon.show()
		else:
			if is_node_ready():
				cameraFootage.show()
				cameraIcon.hide()
@export var cameraImage: Texture2D:
	set(value):
		cameraImage = value
		if is_node_ready():
			cameraFootage.texture = value
@export var firstName: String = "Joe":
	set(value):
		firstName = value
		if is_node_ready():
			nameLabel.text = firstName + " " + lastName
			initialsLabel.text = firstName[0].to_upper() + lastName[0].to_upper()
@export var lastName: String = "Mama":
	set(value):
		lastName = value
		if is_node_ready():
			nameLabel.text = firstName + " " + lastName
			initialsLabel.text = firstName[0].to_upper() + lastName[0].to_upper()
@export var talking: bool = false:
	set(value):
		talking = value
		if is_node_ready():
			talkingPanel.visible = talking

func kick():
	queue_free()

func importFromUser(user: Zoom.User):
	tileUser = user
	#print(name+" "+user.firstName+" "+user.lastName)
	firstName = user.firstName
	lastName = user.lastName
	cameraImage = user.cameraImage
	cameraOff = user.cameraOff
	muted = user.muted
	if muted:
		talking = false
	else:
		talking = user.talking
	if user.type == Zoom.UserType.HACKER:
		var hacker: Zoom.Hacker = user as Zoom.Hacker
		deathProgressBar.visible = true
		deathProgressBar.value = hacker.deathProgress
	else:
		deathProgressBar.visible = false
			

func _ready() -> void:
	modulate.a = 1.0 - float(invisible)
	nameLabel.text = firstName + " " + lastName
	initialsLabel.text = firstName[0].to_upper() + lastName[0].to_upper()
	cameraFootage.texture = cameraImage
	if cameraOff:
		cameraIcon.show()
		cameraFootage.hide()
	else:
		cameraFootage.show()
		cameraIcon.hide()
	if muted:
		muteIcon.show()
	else:
		muteIcon.hide()


func _on_dropdown_button_pressed() -> void:
	if dropdown==null and not invisible:
		dropdown=load('res://Dropdown.tscn').instantiate()
		dropdown.user = tileUser
		get_tree().current_scene.add_child(dropdown)
	elif dropdown != null:
		dropdown.queue_free()
		dropdown=null
