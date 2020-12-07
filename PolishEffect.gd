extends Particles2D

func _ready():
	self.position = get_local_mouse_position()

func _process(_delta):
	pass
	#if Global.polishing:
	#	self.emitting = true
	#else:
	#	self.emitting = false
