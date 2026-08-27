extends CanvasLayer

@export var group : ButtonGroup

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func dev_button_pressed() -> void:
	var button = group.get_pressed_button()
	
	Profile.set_user_icon(button.user_icon_id)
	Profile.set_user_name(button.user_name)
	Profile.show_profile()


func _on_custom_button_pressed() -> void:
	get_tree().change_scene_to_file(Global.current_scene)
	Global.is_scene_credits = false
