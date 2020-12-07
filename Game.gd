extends Node

var dream_rock_scene = load("res://DreamRock.tscn")
var dream_rock_node

var darkness_scene = load("res://Darkness.tscn")
var darkness_node

var coin_scene = load("res://Coin.tscn")
var coin_node

var background_stars_scene = load("res://BackgroundStars.tscn")
var background_stars_node

var time_since_yesterday = 0

var rng = RandomNumberGenerator.new()

var screen_size

func _ready():
	rng.randomize()
	screen_size = get_viewport().get_visible_rect().size
	
	for i in 100:
		background_stars_node = background_stars_scene.instance()
		background_stars_node.position = Vector2(rng.randi_range(0,screen_size[0]), rng.randi_range(0,screen_size[1]))
		add_child(background_stars_node)
	
	dream_rock_node = dream_rock_scene.instance()
	add_child(dream_rock_node)
	
	darkness_node = darkness_scene.instance()
	add_child(darkness_node)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Global.game_state == "In progress") and Input.is_action_just_released("ui_escape"):
		Global.game_state = "Paused"
	if (Global.game_state == "Menu") and Input.is_action_just_released("ui_escape"):
		Global.game_state = "Resumed"
		
	if Global.game_state == "In progress":
		
		time_since_yesterday += delta * Global.time_scale
		if time_since_yesterday > 30:
			time_since_yesterday = 0
			#Global.last_event = "Years passed"
			coin_node = coin_scene.instance()
			coin_node.position = Vector2(rand_range(100, screen_size[0] - 100), rand_range(200, screen_size[1]) - 100)
			if rng.randi_range(0, 1):
				coin_node.healthy = true
			else:
				coin_node.healthy = false
			add_child(coin_node)
			print("Coin spawned, healthy = ", str(coin_node.healthy))
