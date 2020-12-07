extends Area2D

const DAY = 60 # 1 minute is 1 day (or year>)

var attention_state
var negligence_timer = DAY * 5

var attending = false

var last_mouse_pos

var dream_rock_sprite_scene = load("res://DreamRockSprite.tscn")
var dream_rock_sprite_node

var polish_effect_scene = load("res://PolishEffect.tscn")
var polish_effect_node

var hand_cursor = load("res://Hand2.png")

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Global.game_state == "In progress":
		
		if attending and Input.is_action_just_released("ui_rightclick"):
			Global.rock_state = "Hatching"
			Global.game_state = "Over"
		
		if attending and not $MouseOverAnimations.is_playing():
			$MouseOverAnimations.play("MouseOver")
		
		if attending and (negligence_timer > 0):
			if last_mouse_pos != get_global_mouse_position():
				negligence_timer -= delta * Global.time_scale
		if attending and (last_mouse_pos != get_global_mouse_position()) and Input.is_action_pressed("ui_leftclick"):
				Global.polish_timer += delta * Global.time_scale
				Global.polishing = true
				polish_effect_node = polish_effect_scene.instance()
				polish_effect_node.emitting = true
				add_child(polish_effect_node)
				if not $PolishAnimations.is_playing():
					$PolishAnimations.play("Polish")
				#if not $PolishSound.playing:
				#	$PolishSound.playing = true
				if $Sparkle.amount < int(Global.polish_timer / 60):
					$Sparkle.amount = int(Global.polish_timer / 60)
				if int(Global.polish_timer) % 60 == 0:
					dream_rock_sprite_node = dream_rock_sprite_scene.instance()
					dream_rock_sprite_node.modulate = Color(1, 1, 1, 0.2)
					add_child(dream_rock_sprite_node)
					print("added layer of rock: ", str(int(Global.polish_timer)))
					Global.polish_timer += 1
					#$Sparkle.amount += 1
					if not $Sparkle.emitting:
						$Sparkle.emitting = true
				Global.last_event = "You are polishing your dream rock."
		else:
			Global.polishing = false
			if $PolishAnimations.is_playing():
				$PolishAnimations.stop()
		if not attending:
			negligence_timer += delta * Global.time_scale
			if $MouseOverAnimations.is_playing():
				$MouseOverAnimations.stop()
		
		
		$TimeSinceLastPet.text = str(int(negligence_timer))
		
		if negligence_timer < DAY:
			attention_state = "Loved"
			
		elif negligence_timer < DAY * 2:
			attention_state = "Cared for"
			
		elif negligence_timer < DAY * 3:
			attention_state = "Looked after"
			
		elif negligence_timer < DAY * 4:
			attention_state = "Tended to"
			
		elif negligence_timer < DAY * 5:
			attention_state = "Kept in mind"
			
		elif negligence_timer < DAY * 6: # TRANSITION STATE
			attention_state = "Alive"
			
		elif negligence_timer < DAY * 7:
			attention_state = "Disregarded"
			
		elif negligence_timer < DAY * 8:
			attention_state = "Neglected"
			
		elif negligence_timer < DAY * 9:
			attention_state = "Abandoned"
			
		elif negligence_timer < DAY * 10:
			attention_state = "Forgotten"
			
		else:
			attention_state = "Dead"
			Global.game_state = "Over"
			Global.rock_state = "Dead"
			
		$AttentionStateLabel.text = attention_state
		
		self.modulate = Color (1, 1, 1, (600 - negligence_timer)/600)

		last_mouse_pos = get_global_mouse_position()


func _on_DreamRock_mouse_entered():
	if Global.game_state == "In progress":
		attending = true
		$DreamRockHighlight.enabled = true
		Input.set_custom_mouse_cursor(hand_cursor)
		Global.last_event = "You are attending your pet rock."


func _on_DreamRock_mouse_exited():
	if Global.game_state == "In progress":
		attending = false
		$DreamRockHighlight.enabled = false
		Input.set_custom_mouse_cursor(null)
		Global.last_event = ""
