extends CanvasLayer

var is_screen_on : bool = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var screen_animation: AnimationPlayer = $ScreenAnimation
@onready var screen: ColorRect = $Screen


func expand_monitor() -> bool:
	animation_player.play("GameStart")
	await animation_player.animation_finished
	return true


func _on_button_mouse_entered() -> void:
	animation_player.play("ExpandIcon")


func _on_button_mouse_exited() -> void:
	animation_player.play_backwards("ExpandIcon")


func _on_button_pressed() -> void:
	print("Жмак")
	if is_screen_on == false:
		screen_animation.play("TurnOn")
		await screen_animation.animation_finished
		print("Включили")
		screen.visible = false
		is_screen_on = true
	else:
		screen.visible = true
		screen_animation.play_backwards("TurnOn")
		await screen_animation.animation_finished
		print("Выключили")
		is_screen_on = false
