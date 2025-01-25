class_name MainMenu
extends Control

@onready var quit_button: Button = $TextureRect/Button2 as Button
@onready var start_button: Button = $TextureRect/Button as Button
@export var start_level = preload("res://main.tscn")

#For contrast change
@onready var map1 = $TextureRect
@onready var map2 = $FloatingTausta
@onready var map3 = $"Käsiirti"

var change = 1.0
var counter = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	start_button.button_down.connect(on_start_pressed)
	quit_button.button_down.connect(on_quit_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:
	
	counter += 1
	
	if counter >= 30:
		change -= 0.08
	
	map1.material.set("shader_parameter/contrast", change)
	map2.material.set("shader_parameter/contrast", change)
	map3.material.set("shader_parameter/contrast", change)

func on_start_pressed() -> void:
	get_tree().change_scene_to_packed(start_level)

func on_quit_pressed() -> void:
	get_tree().quit()
