extends CanvasLayer

var is_screen_on : bool = false

@onready var animation_button: AnimationPlayer = $Button/AnimationButton
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var screen_animation: AnimationPlayer = $ScreenAnimation
@onready var screen: ColorRect = $Screen

# Звуки
@onready var monitor_sound: AudioStreamPlayer2D = $MonitorSound
@onready var turn_on_sound: AudioStreamPlayer2D = $TurnOnSound
@onready var turn_off_sound: AudioStreamPlayer2D = $TurnOffSound

func _on_button_mouse_entered() -> void:
	animation_button.play("ExpandIcon")


func _on_button_mouse_exited() -> void:
	animation_button.play_backwards("ExpandIcon")


func _on_button_pressed() -> void:
	if is_screen_on == false:
		expand_screen()
	else:
		shrink_screen()

func expand_screen():
	turn_on_sound.play()
	screen_animation.play("TurnOn")
	animation_player.play("GameStart")
	await screen_animation.animation_finished
	await animation_player.animation_finished
	screen.visible = false
	is_screen_on = true

func shrink_screen():
	turn_off_sound.play()
	screen.visible = true
	screen_animation.play_backwards("TurnOn")
	animation_player.play_backwards("GameStart")
	await screen_animation.animation_finished
	await animation_player.animation_finished
	is_screen_on = false
