extends CanvasLayer

@export var group : ButtonGroup

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	visible = true
	animation_player.play("ShowMenu")

func button_pressed() -> void:
	var button = group.get_pressed_button()
	
	# Штуку для кнопки старт можно было бы вынести в отдельную функцию, но она используется только один раз по сути, поэтому ну нафиг
	if button.button_name == "StartButton":
		NoTouchRect.visible = true
		animation_player.play_backwards("ShowMenu")
		await animation_player.animation_finished
		animation_player.play("HideBackground")
		await animation_player.animation_finished
		$Background.visible = false
		get_tree().change_scene_to_file("res://Game/Main/Scenes/registration.tscn")
		NoTouchRect.visible = false
	elif button.button_name == "ExitButton":
		get_tree().quit()
