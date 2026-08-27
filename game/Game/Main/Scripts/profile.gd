extends CanvasLayer

@onready var icon_frame: AnimatedSprite2D = $ScrollContainer/Control/BackPanel/Top/IconFrame
@onready var user_name_label: Label = $ScrollContainer/Control/BackPanel/Top/UserNameLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_user_icon(icon_id : int):
	icon_frame.frame = icon_id

func set_user_name(text : String):
	user_name_label.text = text

func _on_custom_button_pressed() -> void:
	visible = false

func show_profile() -> void:
	visible = true
