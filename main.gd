extends Node
var bubble_scene = preload("res://bubble.tscn")
var hand_scene = preload("res://Scripts/node_2d.tscn").instantiate()
var main_menu = preload("res://main_menu.tscn").instantiate()
@export var bubble_counter = 0
@export var click_resistance = 1
@export var MAX_BUBBLE_COUNTER = 15
var click_counter = 0
var bubble_counter_limit1 = 5
var bubble_counter_limit2 = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bubble_counter = 0
	click_counter = 0
	start_bubble_counter_timer()
	start_click_resistance_timer()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if Input.is_action_just_pressed("left_click"):
		click_counter += 1
		if click_counter >= click_resistance:
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
	
	await get_tree().create_timer(5).timeout
	
	if bubble_counter < bubble_counter_limit1:
		print_debug("Too low")
	elif bubble_counter < bubble_counter_limit2:
		print_debug("Even lower boy")

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
