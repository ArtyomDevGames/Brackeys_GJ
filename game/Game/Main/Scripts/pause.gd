extends CanvasLayer

@export var group : ButtonGroup
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	pass 

func button_pressed() -> void:
	var button = group.get_pressed_button()
	
	if button.button_name == "ContinueButton":
		animation_player.play_backwards("ShowPause")

func show_pause() -> bool:
	visible = true
	NoTouchRect.visible = true
	animation_player.play("ShowPause")
	await animation_player.animation_finished
	NoTouchRect.visible = false
	return true

func hide_pause() -> bool:
	NoTouchRect.visible = true
	animation_player.play_backwards("ShowPause")
	await animation_player.animation_finished
	NoTouchRect.visible = false
	visible = false
	return true
