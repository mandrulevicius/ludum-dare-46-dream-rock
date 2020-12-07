extends Sprite

func _process(_delta):
	self.modulate = Color(1, 1, 1, (600 - Global.player_health)/600)
