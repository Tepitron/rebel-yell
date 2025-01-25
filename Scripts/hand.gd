extends CharacterBody2D


@onready var movement_area = $"../movement_area"

const SPEED = 100.0
const radius = 50


func _physics_process(delta: float) -> void:
	# Thank you David Wong from the godot forums
	var mouse_pos = get_global_mouse_position()
	var player_pos = movement_area.global_transform.origin 
	var distance = player_pos.distance_to(mouse_pos) 
	var mouse_dir = (mouse_pos-player_pos).normalized()
	if distance > radius:
		mouse_pos = player_pos + (mouse_dir * radius)
	global_transform.origin = mouse_pos
	
