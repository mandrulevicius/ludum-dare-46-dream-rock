extends Node
# Scene handler

var main_menu_scene = load("res://MainMenu.tscn")
var main_menu_node

var game_scene = load("res://Game.tscn")
var game_node

var game_over_scene = load("res://GameOver.tscn")
var game_over_node

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Global.game_state == "New":
		main_menu_node = main_menu_scene.instance()
		add_child(main_menu_node)
		print("from: ", Global.game_state)
		Global.game_state = "Launched"
		print("to: ", Global.game_state)
		
	elif Global.game_state == "Started":
		main_menu_node.queue_free()
		game_node = game_scene.instance()
		add_child(game_node)
		print("from: ", Global.game_state)
		Global.game_state = "In progress"
		print("to: ", Global.game_state)
		
	elif Global.game_state == "Paused":
		main_menu_node = main_menu_scene.instance()
		add_child(main_menu_node)
		print("from: ", Global.game_state)
		Global.game_state = "Menu"
		print("to: ", Global.game_state)
		
	elif Global.game_state == "Resumed":
		main_menu_node.queue_free()
		print("delete menu")
		print("from: ", Global.game_state)
		Global.game_state = "In progress"
		print("to: ", Global.game_state)
		
	elif Global.game_state == "Over":
		Input.set_custom_mouse_cursor(null)
		game_over_node = game_over_scene.instance()
		add_child(game_over_node)
		game_node.queue_free()
		print("from: ", Global.game_state)
		Global.game_state = "Game Over Screen"
		print("to: ", Global.game_state)
		
	elif Global.game_state == "Restarted":
		game_over_node.queue_free()
		Global.reset()
		yield(get_tree(), "idle_frame")
		game_node = game_scene.instance()
		add_child(game_node)
		print("from: ", Global.game_state)
		Global.game_state = "In progress"
		print("to: ", Global.game_state)
