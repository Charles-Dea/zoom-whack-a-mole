extends GridContainer

var totalTime: float = 0
var freq: float = 1
@onready var user: Zoom.User = Zoom.User.new("Skibidi", "Toilet", false, true, false, Globals.load_image("skibidi"), 1, 1, 1)
func _ready() -> void:
	user.talking = true
	pass

func _process(delta: float) -> void:
	#pass
	totalTime += delta
	if totalTime > freq:
		totalTime = fmod(totalTime, freq)
		user.row = randi_range(1,5)
		user.col = randi_range(1,5)
