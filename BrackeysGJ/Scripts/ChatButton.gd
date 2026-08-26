class_name ChatButton extends Button

@export var ProfileName: String
var ChatManagerNode:ChatManager

func _ready() -> void:
	ChatManagerNode = get_tree().get_first_node_in_group("ChatManager")

func _pressed() -> void:
	ChatManagerNode.ChatName = ProfileName
