extends CharacterBody2D

@export var turn_velocity := 0.0

const MAX_TURN_SPEED := 300.0
const MAX_SPEED := 300.0


func _physics_process(delta: float) -> void:
	var accel_vs_brake := Input.get_axis("brake", "accelerate") 
	var local_velocity := Vector2(0.0, -MAX_SPEED)
	
	var turn_direction := Input.get_axis("turn_left","turn_right")
	turn_velocity = move_toward(turn_velocity, turn_direction, MAX_TURN_SPEED * delta)
	rotation = clampf(rotation + turn_velocity * delta, deg_to_rad(-15.0), deg_to_rad(15.0))
	velocity = local_velocity.rotated(rotation)
	move_and_slide()
