extends Node


func _on_RestartButton_button_up():
	Global.game_state = "Restarted"


func _on_QuitButton_button_up():
	get_tree().quit()
