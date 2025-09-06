extends Panel
@export var str=''
func _ready():
	var rng=RandomNumberGenerator.new()
	rng.randomize()
	for i in range(8):str+=char(rng.randi_range(0x41,0x5a)|0b00100000*rng.randi_range(0,1))
	get_node('./Label').text='Type the following:\n'+str
