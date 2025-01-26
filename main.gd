extends Node
var bubble_scene = preload("res://bubble.tscn")
var hand_scene = preload("res://Scripts/node_2d.tscn").instantiate()
var ending = preload("res://ending.tscn")

@onready var fight_audio: AudioStreamPlayer2D = $Node2D/AudioStreamPlayer2D
@onready var background: Sprite2D = $Node2D/FloatingTausta
@onready var head: Sprite2D = $Node2D/Head
@onready var hand_sprite: Sprite2D = $Node2D/Hand/Hand_sprite

@export var bubble_counter = 0
@export var click_resistance = 1
@export var MAX_BUBBLE_COUNTER = 15
var click_counter = 0
var over_all_bubbles = 0
var timers_started = false
@export var blowing_sprite_scale = 1.1
@export var DIFFICULTY_STARTING_LIMIT = 15

@export var bubble_counter_limit1 = 10
@export var bubble_counter_limit2 = 8
@export var bubble_counter_limit3 = 6
@export var bubble_counter_limit4 = 4
@export var bubble_counter_limit5 = 1

var level1 = true
var level2 = false
var level3 = false
var level4 = false
var level5 = false

var level_1_change_done = false
var level_2_change_done = false
var level_3_change_done = false
var level_4_change_done = false
var level_5_change_done = false

var brightness_value = 0
var saturation = 1

var volume = -15

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bubble_counter = 0
	click_counter = 0
	$AnimatedSprite2D.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$AnimatedSprite2D.position.x = $Node2D/Hand.position.x - 30
	$AnimatedSprite2D.position.y = $Node2D/Hand.position.y - 100 

	if Input.is_action_just_pressed("left_click"):
		click_counter += 1
		if click_counter >= click_resistance:
			$AnimatedSprite2D.hide()
			$AnimatedSprite2D.scale = Vector2(1,1)
			# creates a bubble_scene and places it on the hand asset
			var instance = bubble_scene.instantiate()
			instance.position = $Node2D/Hand.position
			instance.position.x += -40
			instance.position.y -= 100
			add_child(instance)
			click_counter = 0
			
			# This limits the bubble_counter from being too much
			if bubble_counter < MAX_BUBBLE_COUNTER:
				bubble_counter += 1
				over_all_bubbles += 1
		else:
			stretch_bubble()
	
	if over_all_bubbles > DIFFICULTY_STARTING_LIMIT:
		if not timers_started:
			start_bubble_counter_timer()
			start_click_resistance_timer()
			timers_started = true
	
		if bubble_counter > bubble_counter_limit1:
			change_level(1)
		
		elif (bubble_counter < bubble_counter_limit1 && 
			bubble_counter > bubble_counter_limit2):
				
			change_level(2)
			
		elif (bubble_counter < bubble_counter_limit2 &&
			 bubble_counter > bubble_counter_limit3):
			
			change_level(3)
		
		elif (bubble_counter < bubble_counter_limit3 &&
			 bubble_counter > bubble_counter_limit4):
			
			change_level(4)
			
		elif(bubble_counter < bubble_counter_limit4 &&
			 bubble_counter > bubble_counter_limit5):
			
			change_level(5)
			
		elif bubble_counter <= 0:
			
				game_over()
			
		if level1 == true && !level_1_change_done:
			level1changes()
			
		elif level2 == true && !level_2_change_done:
			level2changes()
			
		elif level3 == true && !level_3_change_done:
			level3changes()
			
		elif level4 == true && !level_4_change_done:
			level4changes()
		
		elif level5 == true && !level_5_change_done:
			level5changes()
		
		fight_volume()
	
func stretch_bubble():
	$AnimatedSprite2D.show()
	$AnimatedSprite2D.play("kupla_stretch")
	if click_counter > 2:
		if $AnimatedSprite2D.scale.x < 2:
			$AnimatedSprite2D.apply_scale(Vector2(blowing_sprite_scale,blowing_sprite_scale))

func fight_volume():
	#var current_vol = 
	pass
	#fight_audio.volume_db += current_vol*(-1)

func bubble_counter_down():
	bubble_counter -= 1
		
func raise_click_resistance():
	click_resistance += 1
	print_debug("click resistance raised")

func _on_bubble_counter_down_timer_timeout() -> void:
	bubble_counter_down()

func start_bubble_counter_timer():
	$BubbleCounterDownTimer.start()

func start_click_resistance_timer():
	$ClickResistanceUpTimer.start()

func _on_click_resistance_up_timer_timeout() -> void:
	raise_click_resistance()

func change_level(level_number):
	level1 = false
	level2 = false
	level3 = false
	level4 = false
	level5 = false
	
	if level_number == 1:
		level1 = true
	elif level_number == 2:
		level2 = true
	elif level_number == 3:
		level3 = true
	elif level_number == 4:
		level4 = true
	else:
		level5 = true

func game_over():
	if brightness_value > -1.0:
			brightness_value -= 0.01
			volume -= 1
			fight_audio.volume_db = volume
			background.material.set("shader_parameter/brightness", brightness_value)
			head.material.set("shader_parameter/brightness", brightness_value)
			hand_sprite.material.set("shader_parameter/brightness", brightness_value)		
	else:
		get_tree().change_scene_to_packed(ending)
	
func level1changes():
	default_level_change_flags_to_false()
	level_1_change_done = true
	
	saturation_change(0.8)
	print_debug("Level 1 shaders activate")
	volume = -11
	fight_audio.volume_db = volume

func level2changes():
	default_level_change_flags_to_false()
	level_2_change_done = true
	
	saturation_change(0.6)
	print_debug("Level 2 shaders activate")
	volume = -8
	fight_audio.volume_db = volume
	
func level3changes():
	default_level_change_flags_to_false()
	level_3_change_done = true
	
	saturation_change(0.4)
	print_debug("Level 3 shaders activate")
	volume = -5
	fight_audio.volume_db = volume
	
func level4changes():
	default_level_change_flags_to_false()
	level_4_change_done = true
	
	saturation_change(0.2)
	print_debug("Level 4 shaders activate")
	volume = -2
	fight_audio.volume_db = volume
	
func level5changes():
	default_level_change_flags_to_false()
	level_5_change_done = true
	
	saturation_change(0.0)
	print_debug("Level 5 shaders activate")
	volume = 1
	fight_audio.volume_db = volume

func saturation_change(to):
	var difference = saturation-to
	if difference < 0:
		difference *= -1
	var change = difference/10
	var loops = int(difference*50)+1
	
	print(difference)
	print(change)
	print(loops)
	
	if to < saturation:
		for i in range(loops):
			saturation -= change
			background.material.set("shader_parameter/saturation", saturation)
			head.material.set("shader_parameter/saturation", saturation)
			hand_sprite.material.set("shader_parameter/saturation", saturation)
	elif to > saturation:
		for i in range(loops):
			saturation += change
			background.material.set("shader_parameter/saturation", saturation)
			head.material.set("shader_parameter/saturation", saturation)
			hand_sprite.material.set("shader_parameter/saturation", saturation)
	else:
		print("lessgo")
		pass

func saturation_down(from,to):
	pass
	
func default_level_change_flags_to_false():
	level_1_change_done = false
	level_2_change_done = false
	level_3_change_done = false
	level_4_change_done = false
	level_5_change_done = false
