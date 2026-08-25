class_name SceneChangeButton extends Button

#var Original = preload("res://Scenes/MainMenu.tscn")
@export_file ("*.tscn") var SceneToChange:String
func _pressed() -> void:
	#if SceneToChange: Original = SceneToChange
	Global.SceneController.ChangeScene2D(load(SceneToChange))
