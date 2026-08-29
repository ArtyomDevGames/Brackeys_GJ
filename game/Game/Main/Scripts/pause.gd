extends CanvasLayer

@export var group : ButtonGroup
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var blur: ColorRect = $Blur

@onready var name_label: Label = $Panel/Dark/NameLabel


func _ready() -> void:
	name_label.text = Global.PC_user_name

func button_pressed() -> void:
	var button = group.get_pressed_button()
	
	if button.button_name == "ContinueButton": await hide_pause()
	elif button.button_name == "SettingsButton": await show_settings()
	elif button.button_name == "BackButton": await hide_settings()
	elif button.button_name == "ExitButton": get_tree().quit()

# Анимации появления / скрытия меню
# Пауза
func show_pause():
	blur.visible = true
	visible = true
	NoTouchRect.visible = true
	animation_player.play("ShowPause")
	await animation_player.animation_finished
	NoTouchRect.visible = false

func hide_pause():
	NoTouchRect.visible = true
	animation_player.play_backwards("ShowPause")
	await animation_player.animation_finished
	NoTouchRect.visible = false
	blur.visible = false
	visible = false

# Настройки
func show_settings():
	NoTouchRect.visible = true
	animation_player.play("ShowSettings")
	await animation_player.animation_finished
	NoTouchRect.visible = false

func hide_settings():
	NoTouchRect.visible = true
	animation_player.play_backwards("ShowSettings")
	await animation_player.animation_finished
	NoTouchRect.visible = false


func update_name():
	name_label.text = Global.PC_user_name
