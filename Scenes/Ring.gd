extends Node

var player_init_pos = Vector2()
var cpu_init_pos = Vector2()

func _ready():
	
	player_init_pos.x = int($Player_Boxer.global_position.x)
	player_init_pos.y = int($Player_Boxer.global_position.y)
	cpu_init_pos.x = int($CPU_Boxer.global_position.x)
	cpu_init_pos.y = int($CPU_Boxer.global_position.y)
	
	# connect hit
	$Player_Boxer.connect("hit", $CPU_Boxer, "_on_hit")
	$CPU_Boxer.connect("hit", $Player_Boxer, "_on_hit")
	
	# connect health_changed
	$Player_Boxer.connect("health_changed", $HUD, "_on_player_health_changed")
	$Player_Boxer.connect("health_changed", self, "_on_player_health_changed")
	$CPU_Boxer.connect("health_changed", $HUD, "_on_cpu_health_changed")
	$CPU_Boxer.connect("health_changed", $self, "_on_cpu_health_changed")
	
	# connect stamina changed
	$Player_Boxer.connect("stamina_changed", $HUD, "_on_player_stamina_changed")
	$CPU_Boxer.connect("stamina_changed", $HUD, "_on_cpu_health_changed")
	pass


func _on_player_health_changed(value):
	if value <= 0:
		print("CPU won!")
		
func _on_cpu_health_changed(value):
	if value <= 0:
		print("Player won!")