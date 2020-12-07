extends Label

func _process(_delta):
	if Global.game_state == "In progress":
		self.text = Global.last_event
