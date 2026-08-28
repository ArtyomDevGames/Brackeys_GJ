extends CanvasLayer

var is_screen_on : bool = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var screen_animation: AnimationPlayer = $ScreenAnimation
@onready var screen: ColorRect = $Screen

# Звуки
@onready var monitor_sound: AudioStreamPlayer2D = $MonitorSound
@onready var turn_on_sound: AudioStreamPlayer2D = $TurnOnSound
@onready var turn_off_sound: AudioStreamPlayer2D = $TurnOffSound

func expand_monitor() -> bool:
	animation_player.play("GameStart")
	await animation_player.animation_finished
	return true


func _on_button_mouse_entered() -> void:
	animation_player.play("ExpandIcon")


func _on_button_mouse_exited() -> void:
	animation_player.play_backwards("ExpandIcon")


func _on_button_pressed() -> void:
	if is_screen_on == false:
		turn_on_sound.play()
		screen_animation.play("TurnOn")
		await screen_animation.animation_finished
		screen.visible = false
		is_screen_on = true
	else:
		turn_off_sound.play()
		screen.visible = true
		screen_animation.play_backwards("TurnOn")
		await screen_animation.animation_finished
		is_screen_on = false
