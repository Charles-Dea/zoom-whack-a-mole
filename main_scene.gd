extends Control

var user_list: Array[Zoom.User] = []
@onready var leftButton: Button = $UIStack/NavAndMain/LeftButtonParent/LeftButton
@onready var rightButton: Button = $UIStack/NavAndMain/RightButtonParent/RightButton

@export var current_page = 1:
	set(value):
		current_page = value
		change_page_to(current_page)
		update_nav_buttons()

var till_next_user: int
		
func max_page() -> int:
	var max_page_index = 1
	for user in user_list:
		max_page_index = max(user.page, max_page_index)
	return max_page_index

func current_page_users():
	return user_list.filter(func(u): return u.page == current_page)

func change_page_to(new_page: int):
	Globals.empty_all_zoom_tiles()
	var current_users = current_page_users()
	Globals.show_zoom_tiles(current_users)
	
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
	var user1 = Zoom.User.new("Test", "Person", true, true, false, Globals.load_image("doggo"), 2, 2, 1)
	var user2 = Zoom.User.new("Test2", "Person2", true, true, false, Globals.load_image("wakeup"), 1, 1, 1)
	var user3 = Zoom.User.new("Test3", "Person3", true, true, false, Globals.load_image("wakeup"), 5, 5, 3)
	user_list = [user1, user2, user3]
	current_page = 1

func _process(delta: float) -> void:
	for user in user_list:
		user.updateUser(delta)

func _on_left_button_pressed() -> void:
	current_page -= 1

func _on_right_button_pressed() -> void:
	current_page += 1
