extends Control
@onready var texture_rect: TextureRect = %TextureRect
@onready var label: Label = %Label

@export var reaction_textures : Dictionary[String,Texture2D]
var CD := 5000.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Time.get_ticks_msec() >= CD:
		CD = Time.get_ticks_msec() + 10000.0 + randf() * 10000.0
		_emote()

func _emote() -> void:
	texture_rect.texture = reaction_textures["Drink"]
	get_tree().create_timer(1.5).timeout.connect(func() -> void:
		texture_rect.texture = reaction_textures["Idle"]
	)

func update_score(score:int) -> void:
	label.text = "Score: " + str(score)
	
	
