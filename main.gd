extends Node
var bubble_scene = preload("res://bubble.tscn")
var hand_scene = preload("res://Scripts/node_2d.tscn").instantiate()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left_click"):
		var instance = bubble_scene.instantiate()
		instance.position = $Node2D/Hand.position
		instance.position.x += -40
		instance.position.y -= 100
		add_child(instance)
