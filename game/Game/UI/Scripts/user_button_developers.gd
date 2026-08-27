extends "res://Game/UI/Scripts/user_button.gd"

@export var developer_role : String

@onready var role_label: Label = $RoleLabel

func _ready() -> void:
	set_role()
	set_icon()
	set_users_name()

func set_role() -> void:
	role_label.text = developer_role
