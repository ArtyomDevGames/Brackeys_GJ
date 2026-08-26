extends Button

@export var button_theme : Theme
@export var button_name : String
@export var button_text : String

func _ready() -> void:
	set_button_text()

func set_button_text() -> void:
	text = button_text
