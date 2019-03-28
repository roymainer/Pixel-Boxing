extends "res://Boxers/Boxer.gd"

func _control(delta):
	
	velocity = Vector2()
	
	if Input.is_action_pressed('boxer_defend'):
		velocity.x = -speed
	if Input.is_action_pressed('boxer_step'):
		velocity.x = speed
	if Input.is_action_just_pressed('boxer_heavy'):
		heavy_punch()
	if Input.is_action_just_pressed('boxer_jab'):
		jab()