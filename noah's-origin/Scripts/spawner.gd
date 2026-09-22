extends Node2D

var spots : Array[Node]
var cd := 0.0
var minCD := 0.5
var maxCD := 2.0
@export var john_guy_scns : PackedScene
@export var obstacle_scns : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if spots.is_empty():
		spots = get_children()
	if (Time.get_ticks_msec() >= cd):
		cd = Time.get_ticks_msec() + randf_range(minCD,maxCD) * 1000
		spawn_things()
		
func spawn_things() -> void:
	if spots.is_empty():
		return
	var spawnrow :Array[Node2D]= []
	for node:Node2D in spots:
		match randf():
			var x when x < 0.3:
				var new_guy = john_guy_scns.instantiate()
				get_tree().current_scene.add_child(new_guy)
				spawnrow.append(new_guy)
				new_guy.position = node.global_position + Vector2(0.0, (randf() -0.5) *40.0 )
			var x when x < 0.7:
				var new_obs = obstacle_scns.instantiate()
				get_tree().current_scene.add_child(new_obs)
				spawnrow.append(new_obs)
				new_obs.position = node.global_position
			_:
				spawnrow.append(null)
