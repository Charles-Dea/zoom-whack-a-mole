extends Node

func _ready() -> void:
	randomize()
	
const minSpawnFreq: float = 1.0
const startingMinSpawnFreq: float = 2.0
const startingMaxSpawnFreq: float = 3.5

const minSpawnFreqPctChange: float = .02
const maxSpawnFreqPctChange: float = .1

const startingHackerChance: float = .4
const maxHackerChance: float = .75

const startingHackerDifficulty: float = .2
const maxHackerDifficulty: float = 1.0

const hackerDoomsdayMinimum: float = 10
const hackerDoomsdayMaximum: float = 20

const startingUserCountMin: int = 1
const startingUserCountMax: int = 1

const userCameraOnInMin: int = 3
const userCameraOnInMax: int = 20
const userCameraOnChance: float = .2

const hackerDeathPenalty: float = .025
const userDeathPenalty: float = .05

var gameOver: bool = false

@export var score = 0

func adjustSpawnFreqBy(currentMin: float, currentMax: float, pctStep: float) -> Array[float]:
	return [currentMin + (minSpawnFreq - currentMin) * pctStep, currentMax + (minSpawnFreq - currentMax) * pctStep]

func load_image(image_name: String="wakeup.jpg"):
	return load("res://img/pfp/"+image_name)
	
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

func show_zoom_tiles(users: Array):
	for user in users:
		show_zoom_tile_at(user.row, user.col)

func reset_zoom_tiles(users: Array):
	for user in users:
		get_zoom_tile(user.row, user.col).importFromUser(user)

func random_first_name():
	var options = ["James", "Michael", "John", "Robert", "David", "William", "Richard", "Joseph", "Thomas", "Christopher", "Charles", "Daniel", "Matthew", "Anthony", "Mark", "Steven", "Donald", "Andrew", "Joshua", "Paul", "Kenneth", "Kevin", "Adrian", "Maximilian", "Mary", "Patricia", "Jennifer", "Linda", "Elizabeth", "Barbara", "Susan", "Jessica", "Karen", "Sarah", "Lisa", "Nancy", "Sandra", "Ashley", "Emily", "Kimberly", "Betty", "Margaret", "Donna", "Michelle", "Carol", "Amanda", "Melissa", "Deborah", "Stephanie"]
	return options[randi() % options.size()]

func random_last_name():
	var options = ["Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller", "Davis", "Rodriguez", "Martinez", "Hernandez", "Lopez", "Gonzales", "Wilson", "Anderson", "Thomas", "Taylor", "Moore", "Jackson", "Martin", "Lee", "Perez", "Thompson", "White", "Harris", "Sanchez", "Clark", "Ramirez", "Lewis", "Robinson", "Walker", "Young", "Allen", "King", "Wright", "Scott", "Torres", "Nguyen", "Hill", "Flores", "Green", "Adams", "Nelson", "Baker", "Hall", "Rivera", "Campbell", "Panezic", "Dea", "Harold"]
	return options[randi() % options.size()]

func random_pfp():
	var names = get_pfp_names()
	var chosen_name = names.pick_random()
	return load_image(chosen_name)

func get_pfp_names() -> Array[String]:
	#var files: Array[String] = []
	#var path = "res://img/pfp"
	#var dir = DirAccess.open(path)
	#if dir:
		#dir.list_dir_begin()
		#var filename = dir.get_next()
		#while filename != "":
			#var ext = filename.get_extension().to_lower()
			#if ext in ["png", "jpg", "jpeg"]:
				#if not dir.current_is_dir():
					#files.append(filename.get_file())  # removes extension
			#filename = dir.get_next()
		#dir.list_dir_end()
	#else:
		#push_error("Cannot open directory: " + path)
	#print(files)
	var files: Array[String] = ["Annoyed Kitty.jpg", "Annoyed Pakistani.png", "Confused Bro.png", "doggo.jpg", "Girl and Cat Stare.png", "Girl Stare.png", "Goofy Man.png", "Happy Sammy.jpg", "Linus Stare.jpg", "Oops kid.png", "Peeker.png", "wakeup.jpg", "Walked In On Myself.png"]
	return files

func get_the_tree():
	return get_tree()
func endGame():
	get_tree().change_scene_to_file('res://GameOver.tscn')
