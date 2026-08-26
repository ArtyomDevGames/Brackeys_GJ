extends CanvasLayer

@export var group : ButtonGroup
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var blur: ColorRect = $Blur


func _ready() -> void:
	pass 

func button_pressed() -> void:
	var button = group.get_pressed_button()
	
	if button.button_name == "ContinueButton": hide_pause()
	elif button.button_name == "SettingsButton": show_settings()
	elif button.button_name == "BackButton": hide_settings()

# Анимации появления / скрытия меню
# Пауза
func show_pause() -> bool:
	blur.visible = true
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
	blur.visible = false
	visible = false
	return true

# Настройки
func show_settings() -> bool:
	NoTouchRect.visible = true
	animation_player.play("ShowSettings")
	await animation_player.animation_finished
	NoTouchRect.visible = false
	return true

func hide_settings() -> bool:
	NoTouchRect.visible = true
	animation_player.play_backwards("ShowSettings")
	await animation_player.animation_finished
	NoTouchRect.visible = false
	return true
