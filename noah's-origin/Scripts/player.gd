extends CharacterBody2D


@onready var canvas_group: CanvasGroup = %CanvasGroup

@export var turn_velocity := 0.0


var turning_tween :Tween
const ACCELERATION := 1000.0
const MAX_TURN_ACCEL := 3000.0
const MAX_TURN_SPEED := 100.0
const BRAKE_ACCEL := 2000.0
const MAX_HORIZONTAL_VEL := 800.0
const HORIZONTAL_ACCEL := 1500.0

var MAX_SPEED := 1000.0


var desired_local_velocity := Vector2.ZERO
var save_vel := Vector2.ZERO

func _ready() -> void:
	var shader_mat := canvas_group.material as ShaderMaterial
	var tween := create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_method(
		func (val:float) -> void:
			shader_mat.set_shader_parameter("line_thickness", val)
			,4.0,8.0,0.5)
	tween.tween_method(
		func (val:float) -> void:
			shader_mat.set_shader_parameter("line_thickness", val)
			,8.0,4.0,0.5)
	tween.set_loops()

func _physics_process(delta: float) -> void:
	var accel := Input.is_action_pressed("accelerate")
	var brake := Input.is_action_pressed("brake")
	desired_local_velocity = Vector2(0.0,-MAX_SPEED if (accel and (not brake)) else 0.0 )
	var turn_direction := Input.get_axis("turn_left","turn_right")
	turn_velocity = clampf( move_toward(turn_velocity, MAX_TURN_SPEED * turn_direction, MAX_TURN_ACCEL * delta), deg_to_rad(-MAX_TURN_SPEED), deg_to_rad(MAX_TURN_SPEED))
	if (absf(turn_direction) < 0.5):
		if turning_tween == null:
			turning_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
			turning_tween.tween_property(self,"rotation", 0.0, 0.2)
		save_vel.x = 0.0
	else:
		
		rotation = clampf(rotation + turn_velocity * delta, deg_to_rad(-15.0), deg_to_rad(15.0))
		if turning_tween != null:
			turning_tween.kill()
			turning_tween = null
		save_vel.x = turn_direction * MAX_HORIZONTAL_VEL
	velocity = velocity.move_toward(desired_local_velocity.rotated(rotation), ((BRAKE_ACCEL if brake else ACCELERATION) * delta)) 
	velocity.x = move_toward(velocity.x, save_vel.x, HORIZONTAL_ACCEL * delta)
	move_and_slide()
