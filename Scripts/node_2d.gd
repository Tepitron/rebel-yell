extends Node2D
@onready var map1 = $Head
@onready var map2 = $Hand/Hand_sprite
@onready var map3 = $FloatingTausta
var change = -10.0
var rise = false

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	#if change <= -10.0:
	#	rise = true
	#if change >= 2:
	#	rise = false
	
	if change < 0:
		change += 0.1
		print(change)
	else:
		change = 1
	
	
	map1.material.set("shader_parameter/contrast", change)
	map2.material.set("shader_parameter/contrast", change)
	map3.material.set("shader_parameter/contrast", change)
	
	
	
