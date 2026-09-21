extends Area2D

var ray_cast_2d: RayCast2D 
@export var KB := 1000.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _process(delta: float) -> void:
	if ray_cast_2d == null:
		ray_cast_2d = get_node("RayCast2D")
	

func _on_body_entered(body:Node2D) -> void:
	if body is CharacterBody2D:
		var player := (body as CharacterBody2D)
		player.rotation *= -1.0
		player.turn_velocity *= -1.0
		player.velocity += ray_cast_2d.target_position.normalized() * KB
		print(player.velocity)
