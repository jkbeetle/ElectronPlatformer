extends AnimatableBody2D

@export var direction = true
@export var activation_distance = 100
@export var multiplier = 0.5

var origin 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	origin = global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var magnet = get_tree().get_first_node_in_group('magnet')
	var distance = origin.distance_to(magnet.global_position)
	if  distance < activation_distance:
		var translate = (distance-activation_distance)*multiplier
		if !direction:
			translate = -translate
		global_position.y = lerp(global_position.y, origin.y + translate,0.1)
	else:
		global_position.y = lerp(global_position.y, origin.y, 0.1)
