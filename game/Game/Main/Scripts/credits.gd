extends CanvasLayer

@export var group : ButtonGroup

@onready var developers: VBoxContainer = $ScrollContainer/Control/BackPanel/Panel/Developers
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	await show_credits()
	
	for dev in developers.get_children():
		await dev.show_button()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func dev_button_pressed() -> void:
	var button = group.get_pressed_button()
	
	Profile.set_user_icon(button.user_icon_id)
	Profile.set_user_name(button.user_name)
	Profile.show_profile()


func _on_custom_button_pressed() -> void:
	await hide_credits()
	get_tree().change_scene_to_file("res://Game/Main/Scenes/thanks.tscn")


func show_credits():
	NoTouchRect.visible = true
	animation_player.play("ShowCredits")
	await animation_player.animation_finished
	NoTouchRect.visible = false

func hide_credits():
	NoTouchRect.visible = true
	animation_player.play_backwards("ShowCredits")
	await animation_player.animation_finished
	NoTouchRect.visible = false
