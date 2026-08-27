extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	show_registration()


func _on_custom_button_pressed() -> void:
	await hide_registration()
	print("Идём в выбор уровня")
	get_tree().change_scene_to_file("res://Game/Main/Scenes/level_select.tscn")
	Global.current_scene = "res://Game/Main/Scenes/level_select.tscn"

# Анимации появления / скрытия меню
func show_registration():
	NoTouchRect.visible = true
	animation_player.play("ShowRegistration")
	await animation_player.animation_finished
	NoTouchRect.visible = false

func hide_registration():
	NoTouchRect.visible = true
	animation_player.play_backwards("ShowRegistration")
	await animation_player.animation_finished
	NoTouchRect.visible = false
