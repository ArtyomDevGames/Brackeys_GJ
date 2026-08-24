class_name SceneChangeButton extends Button

@export var SceneToChange:PackedScene

func _pressed() -> void:
	Global.SceneController.ChangeScene2D(SceneToChange)
