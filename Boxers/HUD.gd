extends CanvasLayer

onready var player_health_bar = $MarginContainer/HBoxContainer/Player/health_bar
onready var cpu_health_bar = $MarginContainer/HBoxContainer/CPU/health_bar

onready var player_stamina_bar = $MarginContainer/HBoxContainer/Player/stamina_bar
onready var cpu_stamina_bar = $MarginContainer/HBoxContainer/CPU/stamina_bar

func _ready():
	player_health_bar.value = 100
	cpu_health_bar.value = 100
	
	player_stamina_bar.value = 100
	cpu_stamina_bar.value = 100
	pass
	
	
func _on_player_health_changed(value):
	player_health_bar.value = value
	
func _on_cpu_health_changed(value):
	cpu_health_bar.value = value
	
func _on_player_stamina_changed(value):
	player_stamina_bar.value = value
	
func _on_cpu_stamina_changed(value):
	cpu_stamina_bar.value = value
