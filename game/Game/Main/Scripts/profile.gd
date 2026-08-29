extends CanvasLayer

@onready var icon_frame: AnimatedSprite2D = $ScrollContainer/Control/BackPanel/Top/IconFrame
@onready var user_name_label: Label = $ScrollContainer/Control/BackPanel/Top/UserNameLabel
@onready var registration_date: Label = $ScrollContainer/Control/BackPanel/Panel/RegistrationDate
@onready var description: Label = $ScrollContainer/Control/BackPanel/Panel/Description

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func set_user_icon(icon_id : int):
	icon_frame.frame = icon_id

func set_user_name(text : String):
	user_name_label.text = text

func set_user_registration(date : String):
	registration_date.text = "Registration date: []".format([date], "[]")

func set_user_description(desc : String):
	description.text = "Description:
		[]".format([desc], "[]")


func _on_custom_button_pressed() -> void:
	visible = false

func show_profile() -> void:
	visible = true
