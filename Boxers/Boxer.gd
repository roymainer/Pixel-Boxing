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

var current_animation := ""
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


func _ready():
	current_health = max_health
	current_max_stamina = max_stamina
	current_stamina = current_stamina
	anim_player.play("idle")
	pass

func _process(delta):
	if current_health <= 0:
		return
	_control(delta)
	move_and_slide(velocity)
#	print("velocity: {}, position: {}".format([str(velocity), str(position)], "{}"))
	pass

func _physics_process(delta):
	pass
	
func _control(delta):
	# virtual method to be overriden for player and computer
	pass
		
	
func heavy_punch():
	if can_punch == false:
		return

	can_punch = false
	
	var anim = heavy_punches_list[randi() % heavy_punches_list.size()]  # pick random heavy punch
	anim_player.play(anim)
#	yield(get_node("Boxer_Animated_Sprites/AnimationPlayer"), "animation_finished")
#
#	can_punch = true
#	anim_player.play("idle")
	pass
	
func jab():
	if can_punch == false:
		return
	
	can_punch = false
	
	var anim = jabs_list[randi() % jabs_list.size()]  # pick random hand for jab
	anim_player.play(anim)
#	yield(get_node("Boxer_Animated_Sprites/AnimationPlayer"), "animation_finished")
#
#	can_punch = true
#	anim_player.play("idle")
	pass
	
func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"right_heavy", "right_jab", "left_heavy", "left_jab":
			can_punch = true
			anim_player.play("idle")	
	pass # Replace with function body.
