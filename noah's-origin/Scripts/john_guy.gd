extends Area2D

@onready var timer: Timer = %Timer

var DEAD := false
var velocity := Vector2.ZERO
var spin_speed := 20.0

func _ready() -> void:
	body_entered.connect(_on_body_entered)
 
func _on_body_entered(body: Node2D) -> void:
	if DEAD or not (body is CharacterBody2D):
		return
	DEATH(body.velocity * 2.0)

func DEATH(vel: Vector2) -> void:
	velocity = vel
	DEAD = true
	timer.start()

func _on_timer_timeout() -> void:
	queue_free()

func _process(delta: float) -> void:
	if not DEAD:
		return
	position += velocity * delta
	rotation += spin_speed * delta
