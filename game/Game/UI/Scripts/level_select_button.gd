extends Button

@export_range(0, 3) var item_state_id : int # Это за иконку статуста уровня
@export_range(0, 2) var item_id : int # Это за картинку
@export var item_name : String # Это за название уровня

@onready var state_icon: AnimatedSprite2D = $Panel/StateIcon
@onready var item_name_label: Label = $Panel/ItemNameLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_item_name()
	set_item_state_icon()

func set_item_name() -> void:
	item_name_label.text = item_name

func set_item_icon() -> void:
	pass

func set_item_state_icon() -> void:
	if item_state_id != 3: 
		state_icon.visible = true
		state_icon.frame = item_state_id
	else: state_icon.visible = false


func _on_pressed() -> void:
	Global.current_level_name = item_name
	get_tree().change_scene_to_file("res://Game/Main/Scenes/game.tscn")
	Global.current_scene = "res://Game/Main/Scenes/game.tscn"


func _on_mouse_entered() -> void:
	animation_player.play("Hover")

func _on_mouse_exited() -> void:
	animation_player.play_backwards("Hover")
