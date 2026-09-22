extends Node2D


@export var baseline_speed_multi := 1.0 
@onready var player: CharacterBody2D = %Player
@onready var camera_2d: Camera2D = %Camera2D
@onready var baseline: Node2D = %Baseline
@onready var death: Area2D = %Death
@onready var control: Control = %Control

@export var base_game_speed := 500.0
@export var score := 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.point_gain.connect(_on_points)
	player.death.connect(func () -> void:
		control.death(score)
	)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	camera_2d.global_position.y = baseline.global_position.y -(get_viewport_rect().size.y/(2.0 * camera_2d.zoom.y) )
	if absf(baseline.global_position.y - player.global_position.y) > (get_viewport_rect().size.y/(2.0 * camera_2d.zoom.y)):
		print(true)
		death.speed = -player.velocity.y
	else:
		death.speed = base_game_speed

func _on_points() -> void:
	score += 500.0
	control.update_score(score)
