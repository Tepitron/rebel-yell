extends Control

@onready var label_1: Label = $Label
@onready var label_2: Label = $Label2
@onready var label_3: Label = $Label3
@onready var label_4: Label = $Label4
@onready var label_5: Label = $Label5

@export var main_menu = preload("res://main_menu.tscn")

var counter = 0
var brightness = -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	counter += 1
	if counter <= 120:
		label_1.visible = true
		label_1.modulate.r += 0.01
		label_1.modulate.g += 0.01
		label_1.modulate.b += 0.01
	elif counter <= 240:
		label_1.modulate.r -= 0.01
		label_1.modulate.g -= 0.01
		label_1.modulate.b -= 0.01
	elif counter <= 420:
		label_1.visible = false
		label_2.visible = true
		label_2.modulate.r += 0.01
		label_2.modulate.g += 0.01
		label_2.modulate.b += 0.01
	elif counter <= 600:
		label_2.modulate.r -= 0.01
		label_2.modulate.g -= 0.01
		label_2.modulate.b -= 0.01
	elif counter <= 780:
		label_2.visible = false
		label_3.visible = true
		label_3.modulate.r += 0.01
		label_3.modulate.g += 0.01
		label_3.modulate.b += 0.01
	elif counter <= 960:
		label_3.modulate.r -= 0.01
		label_3.modulate.g -= 0.01
		label_3.modulate.b -= 0.01
	elif counter <= 1140:
		label_3.visible = false
		label_4.visible = true
		label_4.modulate.r += 0.01
		label_4.modulate.g += 0.01
		label_4.modulate.b += 0.01
	elif counter <= 1320:
		label_4.modulate.r -= 0.01
		label_4.modulate.g -= 0.01
		label_4.modulate.b -= 0.01
	elif counter <= 1480:
		label_4.visible = false
		label_5.visible = true
		label_5.modulate.r += 0.01
		label_5.modulate.g += 0.01
		label_5.modulate.b += 0.01
	elif counter <= 1660:
		label_5.modulate.r -= 0.01
		label_5.modulate.g -= 0.01
		label_5.modulate.b -= 0.01
	elif counter >= 1800:
		get_tree().change_scene_to_packed(main_menu)
			
