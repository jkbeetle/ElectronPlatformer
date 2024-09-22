extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -440.0

var last_height = 0
var fall_energy = 0

@export var photon:PackedScene


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if fall_energy > 90:
		shoot()
		fall_energy -= 90
	
	if global_position.y > last_height:
		fall_energy +=  global_position.y - last_height
	elif fall_energy > 0:
		printt("current",global_position.y,"last",last_height,"Energy",fall_energy)
		fall_energy = 0
	last_height = global_position.y
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if direction < 0:
			$AnimatedSprite2D.flip_h = true
		else :
			$AnimatedSprite2D.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func shoot() -> void:
	var bullet = photon.instantiate()
	get_parent().add_child(bullet)
	bullet.position = Vector2(global_position.x+15,global_position.y-8)
	
	
