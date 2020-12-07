extends Node


func _on_PlayButton_button_up():
	if Global.game_state == "Launched":
		Global.game_state = "Started"
		print("started")
	elif Global.game_state == "Menu": 
		Global.game_state = "Resumed"
		print("resumed")


func _on_QuitButton_button_up():
	get_tree().quit()
