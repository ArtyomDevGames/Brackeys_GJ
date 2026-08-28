extends Button

@export var button_theme : Theme
@export var button_name : String
@export var button_text : String

@onready var hover_sound: AudioStreamPlayer2D = $HoverSound
@onready var pressed_sound: AudioStreamPlayer2D = $PressedSound


func _ready() -> void:
	set_button_text()
	set_button_theme()

func set_button_text() -> void:
	text = button_text



func _on_pressed() -> void:
	pressed_sound.play()

func _on_mouse_entered() -> void:
	hover_sound.play()

func set_button_theme():
	if button_theme != null: theme = button_theme
