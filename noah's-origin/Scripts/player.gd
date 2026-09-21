extends CharacterBody2D

@export var turn_velocity := 0.0

const ACCELERATION := 1000.0
const MAX_TURN_SPEED := 3000.0
const BRAKE_ACCEL := 2000.0
var MAX_SPEED := 300.0

var local_velocity := Vector2.ZERO

func _physics_process(delta: float) -> void:
	var accel := Input.is_action_pressed("accelerate")
	var brake := Input.is_action_pressed("brake")
	
	local_velocity = Vector2(0.0, move_toward(local_velocity.y, -MAX_SPEED * (1.0 if (accel and (not brake)) else 0.0), ((BRAKE_ACCEL if brake else ACCELERATION) * delta)))
	
	var turn_direction := Input.get_axis("turn_left","turn_right")
	turn_velocity = move_toward(turn_velocity, turn_direction, MAX_TURN_SPEED * delta)
	rotation = clampf(rotation + turn_velocity * delta, deg_to_rad(-15.0), deg_to_rad(15.0))
	velocity = local_velocity.rotated(rotation)
	move_and_slide()
