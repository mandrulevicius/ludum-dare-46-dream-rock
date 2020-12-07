extends Label

const DAY = 50

func _ready():
	# display only one of these at random?
	if Global.player_health <= 0:
		self.text = "You have died. \n Your dream rock has died with you. \n You should have released it while you had the chance."
	else:
		if Global.rock_state == "Dead":
			self.text = ("Your pet rock is dead and forgotten \n " +
				"Your dream to release the rock you always wanted to has dragged on into the abyss of eternal nothingness \n" +
				"You lost, entropy won")
		else:
			
			if Global.polish_timer < DAY:
				self.text = ("You dream rock doesn't stand a chance in the wilds. \n" +
					"You should polish the rock before releasing it.")
			
			elif Global.polish_timer < DAY * 4:
				self.text = ("Your dream rock is barely polished. \n" +
					"It is going to have a rough time out there. \n")
			
			elif Global.polish_timer < DAY * 8:
				self.text = ("Your dream rock is well polished. \n" +
					"You have successfully released it into the wilds. \n")
			
			elif Global.polish_timer < DAY * 12:
				self.text = ("Your dream rock is looking great! \n" +
					"It is quite successful in the wilds. \n")
			
			else:
				self.text = ("Your dream rock has flourished under your care! \n" +
					"It is doing great in the wilds! \n")

