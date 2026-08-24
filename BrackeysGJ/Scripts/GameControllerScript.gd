class_name GameControllerNode extends Node

@export var Game2D: Node
@export var MainScene2D: Node2D
@export var Audio:Node

func _ready() -> void:
	Global.SceneController = self

func ChangeScene2D(ScenePath:PackedScene, Delete: bool = true, Hide:bool = true) -> Node2D:
	print_tree_pretty()
	if MainScene2D:
		if Delete:
			MainScene2D.queue_free()
		elif Hide:
			MainScene2D.hide()
	var NewScene = ScenePath.instantiate()
	Game2D.add_child(NewScene)
	MainScene2D = NewScene
	return NewScene
func ReActivateScene2D(Scene:Node, Delete: bool = true, Hide:bool = true) -> Node2D:
	if MainScene2D:
		if Delete:
			MainScene2D.queue_free()
		elif Hide:
			MainScene2D.hide()
	var NewScene = Scene
	NewScene.show()
	return NewScene
func PlaySFX(SFX:String, MinPitchRange:float = 0.9, MaxPitchRange:float = 1.1):
	var Sound:AudioStreamPlayer
	for child in Audio.get_children():
		if child.name == SFX:
			Sound = child
			break
	Sound.pitch_scale = randf_range(MinPitchRange,MaxPitchRange)
	Sound.play()
