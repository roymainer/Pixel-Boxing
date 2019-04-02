extends "res://Boxers/Boxer.gd"

var target = null


func _ready():
	$Boxer_Animated_Sprites.scale.x = -1  # flip horizontally
	pass
	
func _control(delta):
	velocity = Vector2()
	
	if target:
		if can_punch:
			var punch_type = randi() % 2
			match punch_type:
				0:
					heavy_punch()
				1:
					jab()
		else:
			# defend
			velocity.x = 1  # move right
	else:
		# advance
		velocity.x = -1  # move left
	pass
	
