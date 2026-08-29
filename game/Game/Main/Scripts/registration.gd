extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer


@onready var name_line: LineEdit = $ScrollContainer/Control/BackPanel/ColorRect/VBoxContainer2/NameContainer/NameLine
@onready var username_line: LineEdit = $ScrollContainer/Control/BackPanel/ColorRect/VBoxContainer2/UsernameContainer/UsernameLine
@onready var password_line: LineEdit = $ScrollContainer/Control/BackPanel/ColorRect/VBoxContainer2/PasswordContainer/PasswordLine

@onready var warning_label: RichTextLabel = $ScrollContainer/Control/BackPanel/ColorRect/WarningLabel
@onready var timer: Timer = $Timer

func _ready() -> void:
	await show_registration()
	Monitor.play_music()


func _on_custom_button_pressed() -> void:
	if check_fields() == false:
		name_line.text = ""
		username_line.text = ""
		password_line.text = ""
		
		warning_label.visible = true
		timer.start()
		await timer.timeout
		warning_label.visible = false
	else:
		var tree = Engine.get_main_loop() as SceneTree
		
		await hide_registration()
		Global.Player_name = name_line.text
		Global.PC_user_name = username_line.text
		Pause.update_name()
		
		tree.change_scene_to_file("res://Game/Main/Scenes/level_select.tscn")

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

func check_fields() -> bool:
	if name_line.text.replace(" ", "") == "": return false
	if username_line.text.replace(" ", "") == "": return false
	if password_line.text.replace(" ", "") == "": return false
	
	return true
