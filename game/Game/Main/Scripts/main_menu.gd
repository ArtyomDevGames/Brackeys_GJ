extends CanvasLayer

@export var group : ButtonGroup

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	visible = true
	animation_player.play("ShowMenu")

var is_busy: bool = false

func button_pressed() -> void:
	if is_busy:
		return
	
	var button = group.get_pressed_button()
	if not button:
		return
	
	if button.button_name == "StartButton":
		is_busy = true
		NoTouchRect.visible = true
		animation_player.play_backwards("ShowMenu")
		await animation_player.animation_finished
		animation_player.play("HideBackground")
		await animation_player.animation_finished
		$Background.visible = false
		
		get_tree().change_scene_to_file("res://Game/Main/Scenes/registration.tscn")
		NoTouchRect.visible = false
		
	elif button.button_name == "ExitButton":
		is_busy = true
		get_tree().quit()
