extends CanvasLayer

@export var group : ButtonGroup
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var blur: ColorRect = $Blur

@onready var name_label: Label = $Panel/Dark/NameLabel

@onready var master_slider: HSlider = $SoundSetting/MasterSlider
@onready var music_slider: HSlider = $MusicSetting/MusicSlider

func _ready() -> void:
	name_label.text = Global.PC_user_name
	
	var master_index = AudioServer.get_bus_index("Master")
	var music_index = AudioServer.get_bus_index("Music")
	
	master_slider.value = AudioServer.get_bus_volume_linear(master_index)
	music_slider.value = AudioServer.get_bus_volume_linear(music_index)

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


func _on_master_slider_value_changed(value: float) -> void:
	var bus_index = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_linear(bus_index, value)

func _on_music_slider_value_changed(value: float) -> void:
	var bus_index = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_linear(bus_index, value)
