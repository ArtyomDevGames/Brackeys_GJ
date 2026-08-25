extends Button

@export var NewProfileScene:PackedScene
var NewProfile:Node
@export var ProfileParent:Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _pressed() -> void:
	if not NewProfile:
		NewProfile = NewProfileScene.instantiate()
		NewProfile.get_children()[0].Parent = self
		ProfileParent.add_child(NewProfile)
