extends "res://Game/UI/Scripts/user_button.gd"

@export var developer_role : String
@export var developer_birthday : String
@export var developer_description : String

@onready var role_label: Label = $RoleLabel

func _ready() -> void:
	set_role()
	set_icon()
	set_users_name()
	set_button_theme()

func set_role() -> void:
	role_label.text = developer_role
