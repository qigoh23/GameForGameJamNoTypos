extends Control
@onready var score_label: Label = %ScoreLabel
@onready var restart_button: Button = %RestartButton
@onready var quit_button: Button = %QuitButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func death(score:int) -> void:
	visible = true
	scoreguage(score)
	restart_button.disabled = false
	quit_button.disabled = false

func scoreguage(score:int) -> void:
	score_label.text = "Score: " + str(score)

func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()


func _on_quit_button_pressed() -> void:
	get_tree().quit()
