extends Button

@export var user_name : String
@export_range(0, 1) var user_icon_id : int

@onready var icon_frame: AnimatedSprite2D = $IconFrame
@onready var user_name_label: Label = $UserNameLabel


func _ready() -> void:
	set_icon()
	set_users_name()

func set_users_name():
	user_name_label.text = user_name

func set_icon():
	icon_frame.frame = user_icon_id
