extends Node

export var time_scale = 1
var last_event = ""
var game_state = "New"
var rock_state = "Alive"

var main_timer = 100
var player_health = 600
var polish_timer = 1

var polishing = false


func _ready():
	pass # Replace with function body.


func _process(delta):
	if game_state == "In progress":
		main_timer += delta * time_scale
		player_health -= delta * time_scale * main_timer/600
		if player_health <= 0:
			game_state = "Over"


func reset():
	main_timer = 100
	player_health = 600
	polish_timer = 0
	last_event = ""
