extends Button

@export var user_id : int
@export var user_name : String
@export_range(0, 1) var user_icon_id : int
@export var button_theme : Theme

@onready var icon_frame: AnimatedSprite2D = $IconFrame
@onready var user_name_label: Label = $UserNameLabel

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	set_icon()
	set_users_name()

func set_users_name():
	user_name_label.text = user_name

func set_icon():
	icon_frame.frame = user_icon_id

func set_button_theme():
	if button_theme != null: theme = button_theme

func show_button():
	animation_player.play("ShowButton")
	await animation_player.animation_finished
