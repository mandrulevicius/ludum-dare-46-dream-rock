extends Area2D

var healthy = true

var rng = RandomNumberGenerator.new()

var healthy_events = ["Got a good night sleep. You feel rested.",
	"Ate some healthy food. You feel full but not heavy.",
	"Did some streches. You feel more relaxed as the tension leaves the body.",
	"Went for a walk. You feel better.",
	"Went for a run. You feel soreness in your legs accompanied by a sense of progress.",
	"Worked out. Your muscles are sore, the good kind of sore that feels like improvement.",
	"Did some exercise. Body feels tired while the mind feels refreshed.",
	"Meditated for a while. Your mind feels clear.",
	"Had a good conversation. You feel good.",
	"Had a cold shower. You feel refreshed.",
	"Read a few chapters of a book. You feel inspired."]
	
var other_events = ["You played some games, they were pretty good.",
	"You watched a movie, it was not bad.",
	"You watched some interesting videos.",
	"You scrolled through some social media.",
	"You went online to find a tutorial on polish techniques but somehow ended up watching manicure videos for an hour.",
	"You played some games, they were ok.",
	"You binge watched a whole season of a TV series. It was interesting.",
	"You watched some random videos. Ended up in one of the weird parts of the internet.",
	"You watched a movie, it was alright.",
	"You went out, it was fun."
	]

func _ready():
	rng.randomize()


func _process(_delta):
	#if healthy:
	#	self.modulate = Color(1, 1, 0, 1)
	#else:
		#this is complicated, not sure it adds much, spending too much time on it
		#self.modulate = Color(1, ((600 - Global.player_health) / 600) + ((600 - Global.main_timer)/600), 0, 1)
	#	self.modulate = Color(1, ((600 - Global.main_timer)/500), 0, 1)
	if not $FadeInAnimation.is_playing() and not $IdleAnimation.is_playing():
		$IdleAnimation.play("Idle")


func _on_Button_button_up():
	if healthy and (Global.game_state == "In progress"):
		Global.player_health += 30
		Global.last_event = healthy_events[rng.randi_range(0,10)]
	elif not healthy and (Global.game_state == "In progress"):
		Global.player_health += 1
		Global.last_event = other_events[rng.randi_range(0,9)]
	self.queue_free()
