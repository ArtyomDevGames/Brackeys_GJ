extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	show_registration()


func _on_custom_button_pressed() -> void:
	await hide_registration()
	print("Идём в выбор уровня")
	

# Анимации появления / скрытия меню
func show_registration():
	NoTouchRect.visible = true
	animation_player.play("ShowRegistration")
	await animation_player.animation_finished
	NoTouchRect.visible = false

func hide_registration() -> bool:
	NoTouchRect.visible = true
	animation_player.play_backwards("ShowRegistration")
	await animation_player.animation_finished
	NoTouchRect.visible = false
	return true
