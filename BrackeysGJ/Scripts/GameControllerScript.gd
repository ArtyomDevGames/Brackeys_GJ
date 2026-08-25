class_name GameControllerNode extends Node

@export var Game2D: Node
@export var MainScene2D: Node
@export var Audio:Node
var OutOfMemoryNodes = []

func _ready() -> void:
	Global.SceneController = self

func ChangeScene2D(ScenePath:PackedScene, Delete: bool = true, Hide:bool = true) -> Node:
	if MainScene2D:
		if Delete:
			MainScene2D.queue_free()
		elif Hide:
			remove_child(MainScene2D)
			OutOfMemoryNodes.append(MainScene2D)
	var NewScene = ScenePath.instantiate()
	Game2D.add_child(NewScene)
	MainScene2D = NewScene
	return NewScene
func ReActivateScene2D(Scene:Node, Delete: bool = true, Hide:bool = true) -> Node2D:
	if MainScene2D:
		if Delete:
			MainScene2D.queue_free()
		elif Hide:
			remove_child(MainScene2D)
			OutOfMemoryNodes.append(MainScene2D)
	var NewScene = Scene
	OutOfMemoryNodes.erase(Scene)
	Game2D.add_child(NewScene)
	return NewScene
func PlaySFX(SFX:String, MinPitchRange:float = 0.9, MaxPitchRange:float = 1.1):
	var Sound:AudioStreamPlayer
	for child in Audio.get_children():
		if child.name == SFX:
			Sound = child
			break
	Sound.pitch_scale = randf_range(MinPitchRange,MaxPitchRange)
	Sound.play()
