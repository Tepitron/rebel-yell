# Bubble will spawn from a spawningpoint on the tip of the bubble-blowing stick.
# Blowing animation will be played when the player inputs left-click.
# If left-click is pressed enough a floating bubble will appear.
# The bubble constantly floats upwards, but it sways along the way.
# The sprite size will scale down over time and eventually the bubble will pop

extends Node2D

@export var speed = 1
@export var acceleration = 1.01
@export var SCALE_MIN = 0.985
var sway
var sway_softener = 0.999
var scale_size
var bubble_blowed = false
var go_left = true
var poksed = false
var scale_size_decreaser

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Get spawning_point's position and spawn the bubble there
	#sway gets randomized. Used to determine how fast bubble goes left/right
	sway = randf_range(0,1.5)
	scale_size = $AnimatedSprite2D.scale.x
	scale_size_decreaser = randf_range(0.00005,0.0001)
	# flip a coin if bubble traverses left or right
	go_left = true if (randi_range(0,1) == 1) else false
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# TODO!!! if left click is pressed enough times
	# if Input.is_action_pressed("left_click") or bubble_blowed:
		#flag to ensure this plays out later when mouse is not clicked
		bubble_blowed = true
		$AnimatedSprite2D.play("bubble")
		# AnimatedSprite's size is scaled down. If it is small enough, it 
		# will be popped. Otherwise it continues to scale down and float away
		scale_down()
		if scale_size <= SCALE_MIN:
			pop()
		else:
			go_upwards(delta)
			go_left_or_right(delta)
	
func pop():
	#shows the bubble exploding.waits 0.2 seconds before hiding the asset
	play_popping_audio()
	$AnimatedSprite2D.play("pop")
	await get_tree().create_timer(0.7).timeout
	hide()
	queue_free()	
	
func scale_down():
	# Randomly chooses how fast the scale goes down. When it reaches 0.985,
	# the bubble will pop
	
	scale_size -= scale_size_decreaser
	$AnimatedSprite2D.apply_scale(Vector2(scale_size,scale_size))
	
func go_upwards(delta):
	# changes y according to speed and acceleration.
	acceleration += 1.008
	position.y -= speed * acceleration * delta

func go_left_or_right(delta):
	#x position changes. Flip of the coin decided in ready whether the balloon
	# goes left or right
	if go_left:
		position.x += sway * sway_softener
	else:
		position.x -= sway * sway_softener

func play_popping_audio():
	if poksed == false:
		$AudioStreamPlayer2D.play()
		poksed = true
