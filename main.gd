extends Node
var bubble_scene = preload("res://bubble.tscn")
var hand_scene = preload("res://Scripts/node_2d.tscn").instantiate()
var ending = preload("res://ending.tscn")

@onready var fight_audio: AudioStreamPlayer2D = $Node2D/AudioStreamPlayer2D
@onready var background: Sprite2D = $Node2D/FloatingTausta
@onready var head: Sprite2D = $Node2D/Head
@onready var hand_sprite: Sprite2D = $Node2D/Hand/Hand_sprite
@onready var instruction_1: Sprite2D = $Node2D/Instruction1


@export var bubble_counter = 0
@export var click_resistance = 1
@export var MAX_BUBBLE_COUNTER = 15
var click_counter = 0
var over_all_bubbles = 0
var timers_started = false
@export var blowing_sprite_scale = 1.1

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

var brightness_value = 0

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
			$AnimatedSprite2D.apply_scale(Vector2(1,1))
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
			
			
	# wait x seconds until difficulty levels start rising
	
	if over_all_bubbles > 10:
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
			
		elif bubble_counter == 0:
			print(brightness_value)
			print(bubble_counter)
			if brightness_value > -1.0:
				print("What the fuck")
				brightness_value -= 0.02
				instruction_1.set("shader_parameter/brightness", brightness_value)
				background.material.set("shader_parameter/brightness", brightness_value)
				head.material.set("shader_parameter/brightness", brightness_value)
				hand_sprite.material.set("shader_parameter/brightness", brightness_value)	
			else:
				await get_tree().create_timer(1.2).timeout
				game_over()
			
			
			
		
		if level1 == true:
			level1changes()
			
		elif level2 == true:
			level2changes()
			
		elif level3 == true:
			level3changes()
			
		elif level4 == true:
			level4changes()
		
		elif level5 == true:
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
	get_tree().change_scene_to_packed(ending)
	
func level1changes():
	print_debug("Level 1 shaders activate")

func level2changes():
	print_debug("Level 2 shaders activate")
	
func level3changes():
	print_debug("Level 3 shaders activate")

func level4changes():
	print_debug("Level 4 shaders activate")

func level5changes():
	print_debug("Level 5 shaders activate")


	
