extends CanvasLayer

@export var group : ButtonGroup

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	visible = true
	animation_player.play("ShowMenu")

func button_pressed() -> void:
	var button = group.get_pressed_button()
	
	if button.button_name == "StartButton":
		Monitor.expand_monitor()
		animation_player.play_backwards("ShowMenu")
		await animation_player.animation_finished
