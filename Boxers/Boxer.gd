extends KinematicBody2D

var jabs_list = [
		"right_jab",
		"left_jab"
		]

var heavy_punches_list = [
		"right_heavy",
		"left_heavy"
		]

onready var anim_player := $Boxer_Animated_Sprites/AnimationPlayer

var can_punch := true
var velocity := Vector2()

# Attributes
export var max_health := 100
export var max_stamina := 100  # maximum concecutive punches
export var strength := 100  # punch damage modifier
export var speed := 50  # move speed, animation speed modifier
export var boxer_name := ""

var current_health := 0
var current_max_stamina := 0  # stamina degrades each round, harder to punch multiple times in a row
var current_stamina := 0  #  stamina can accumulate up to current_max_stamina

signal hit
signal health_changed
signal stamina_changed


func _ready():
	$punch_detector_r.enabled = true
	$punch_detector_l.enabled = true
	
	$Boxer_Animated_Sprites.get_node("AnimationPlayer").connect("animation_finished", self, "_on_AnimationPlayer_animation_finished")
	
	current_health = max_health
	current_max_stamina = max_stamina
	current_stamina = current_max_stamina
	anim_player.play("idle")
	
	pass

func _process(delta):
#	if current_health <= 0:
#		return
	
	_control(delta)
	
	velocity.x *= speed	* strength / 100.0
	velocity = move_and_slide(velocity)
	
	# limit movement to ring
	if global_position.x <= -100:
		global_position.x = -100
	elif global_position.x >= 100:
		global_position.x = 100
#	print("velocity: {}, position: {}".format([str(velocity), str(global_position)], "{}"))
	pass


func _control(delta):
	# virtual method to be overriden for player and computer
	pass
		
	
func heavy_punch():
	if can_punch == false:
		return

	can_punch = false
	
	current_stamina -= int(current_stamina * 5.0 / 100.0)  # lose 5% stamina
	emit_signal("stamina_changed", int(current_stamina * 100.0 / max_stamina))  # always emit change in %
	
	var anim = heavy_punches_list[randi() % heavy_punches_list.size()]  # pick random heavy punch
	anim_player.play(anim)
	pass
	
func jab():
	if can_punch == false:
		return
	
	can_punch = false
	
	current_stamina -= int(current_stamina * 2.0 / 100.0)  # lose 2% stamina
	emit_signal("stamina_changed", int(current_stamina * 100.0 / max_stamina))  # always emit change in %
	
	var anim = jabs_list[randi() % jabs_list.size()]  # pick random hand for jab
	anim_player.play(anim)
	pass

func punch(type : String):
	
	var damage = 0
	
	if type.find("heavy") > -1:
		damage = int(strength * current_stamina / 100.0 / 5.0)
		emit_signal("hit", damage)
	elif type.find("jab") > -1:
		damage = int(strength * current_stamina / 100.0 / 20.0)
		emit_signal("hit", damage)
	pass

func knocked_up():
	print(self.name + " knocked up!")
	yield(get_tree().create_timer(3), "timeout")  # delay the program for 3sec before looping and creating a new enemy
	get_parent().get_tree().reload_current_scene()

func _on_hit(damage):
	print("Taken {} damage!".format([damage], "{}"))
	
	# update health
	current_health -= damage  
	if current_health < 0:
		current_health = 0
	emit_signal("health_changed", int(current_health * 100.0 / max_health))
	
	# update stamina
	current_stamina -= int(damage / 2.0)
	if current_stamina < 0:
		current_stamina = 0
	emit_signal("stamina_changed", int(current_stamina * 100.0 / max_stamina))
	
	# update current_max_stamina
	current_max_stamina -= damage / 10.0  
	if current_max_stamina < 10:
		current_max_stamina = 10  # set minimum value, a boxer can always recover some stamina
	
	print (self.name + " : (health/stamina/max_stamina) = ({}, {}, {})".format(
			[current_health, current_stamina, current_max_stamina], "{}"))
	
	if current_health == 0:
		knocked_up()
	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"right_heavy", "right_jab", "left_heavy", "left_jab":
			can_punch = true
			anim_player.play("idle")	
			continue
		"right_heavy", "right_jab":
			if $punch_detector_r.is_colliding():
#				var obj = $punch_detector_r.get_collider()
#				print(obj.get_parent().name)
				punch(anim_name)
		"left_heavy", "left_jab":
			if $punch_detector_r.is_colliding():
#				var obj = $punch_detector_r.get_collider()
#				print(obj.get_parent().name)
				punch(anim_name)
	pass # Replace with function body.
