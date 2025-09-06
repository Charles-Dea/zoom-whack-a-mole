extends Control

var currentMinSpawnFreq: float = Globals.startingMinSpawnFreq
var currentMaxSpawnFreq: float = Globals.startingMaxSpawnFreq

var currentHackerChance: float = Globals.startingHackerChance
var currentHackerDifficulty: float = Globals.startingHackerDifficulty

var user_list: Array = []
@onready var leftButton: Button = $UIStack/NavAndMain/LeftButtonParent/LeftButton
@onready var rightButton: Button = $UIStack/NavAndMain/RightButtonParent/RightButton

@export var current_page = 1:
	set(value):
		current_page = value
		change_page_to(current_page)
		update_nav_buttons()
var elapsedTime: float = 0.0
var till_next_user: int
		
func max_page() -> int:
	var max_page_index = 1
	for user in user_list:
		max_page_index = max(user.page, max_page_index)
	return max_page_index

func page_users_at(page: int):
	return user_list.filter(func(u): return u.page == page)

func current_page_users():
	return page_users_at(current_page)

func available_slots_on_page(pageNumber):
	var slots = []
	for row_index in range(1,6):
		for col_index in range(1,6):
			slots.append([row_index, col_index])
	for user in page_users_at(pageNumber):
		slots.erase([user.row, user.col]) 
	return slots

func generate_user(instant: bool = false):
	if not instant:
		var pctChange: float = randf_range(Globals.minSpawnFreqPctChange, Globals.maxSpawnFreqPctChange)
		var newRange: Array[float] = Globals.adjustSpawnFreqBy(currentMinSpawnFreq, currentMaxSpawnFreq, pctChange)
		currentMinSpawnFreq = newRange[0]
		currentMaxSpawnFreq = newRange[1]
	till_next_user = randf_range(currentMinSpawnFreq, currentMaxSpawnFreq)
	elapsedTime = 0
	
	var newUserPage: int = 1
	while randf() < (float(len(page_users_at(newUserPage))) * 4.0) / 100.0:
		newUserPage += 1
	var pageCoord = available_slots_on_page(newUserPage).pick_random()
	var newUserRow = pageCoord[0]
	var newUserCol = pageCoord[1]
	var chanceRoll: float = randf()
	if chanceRoll <= currentHackerChance:
		var newHacker = Zoom.Hacker.new(Globals.random_first_name(), Globals.random_last_name(), true, false, false, newUserRow, newUserCol, newUserPage)
		if newUserPage == current_page:
			newHacker.focused = true
		user_list.append(newHacker)
	else:
		var cameraOnIn: float = -1
		if randf() > Globals.userCameraOnChance:
			cameraOnIn = randf_range(Globals.userCameraOnInMin, Globals.userCameraOnInMax)
		var newUser = Zoom.User.new(Globals.random_first_name(), Globals.random_last_name(), true, false, false, Globals.random_pfp(), newUserRow, newUserCol, newUserPage, cameraOnIn)
		user_list.append(newUser)
	update_zoom_tiles()
	update_nav_buttons()

func print_users(users: Array[Zoom.User]):
	print()
	for user in users:
		print("%s %s row:%d col:%d page:%d" % [user.firstName, user.lastName, user.row, user.col, user.page])
	print()
		
func change_page_to(new_page: int):
	Globals.empty_all_zoom_tiles()
	var current_users = page_users_at(new_page)
	user_list = user_list.map(func (u):
			if u.page == new_page:
				u.focused = true
			else:
				u.focused = false
			return u
	)
	Globals.reset_zoom_tiles(current_users)
	Globals.show_zoom_tiles(current_users)

func update_zoom_tiles():
	var the_users = current_page_users()
	Globals.empty_all_zoom_tiles()
	user_list = user_list.map(func (u):
			if u.page == current_page:
				u.focused = true
			else:
				u.focused = false
			return u
	)
	Globals.reset_zoom_tiles(the_users)
	Globals.show_zoom_tiles(the_users)
	
func update_nav_buttons():
	if current_page == max_page():
		rightButton.disabled = true
	else:
		rightButton.disabled = false
	if current_page == 1:
		leftButton.disabled = true
	else:
		leftButton.disabled = false

func _ready() -> void:
	var startingUsers = randi_range(Globals.startingUserCountMin,Globals.startingUserCountMax)
	for i in range(startingUsers):
		generate_user(true)
	current_page = 1

func _process(delta: float) -> void:
	for user in user_list:
		user.updateUser(delta)
	elapsedTime += delta
	if elapsedTime >= till_next_user:
		elapsedTime = fmod(elapsedTime, till_next_user)
		generate_user()
	Globals.score+=delta*50

func _on_left_button_pressed() -> void:
	current_page -= 1

func _on_right_button_pressed() -> void:
	current_page += 1
