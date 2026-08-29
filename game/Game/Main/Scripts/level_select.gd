extends CanvasLayer

@export var group : ButtonGroup

@onready var name_label: Label = $ScrollContainer/Control/BackPanel/Panel/NameLabel
@onready var money_label: Label = $ScrollContainer/Control/BackPanel/Panel2/MoneyLabel

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	name_label.text = Global.Player_name
	money_label.text = money_label.text.format([Global.current_money_amount], "[]")
	show_level_select()


func show_level_select():
	NoTouchRect.visible = true
	animation_player.play("ShowLevelSelect")
	await animation_player.animation_finished
	NoTouchRect.visible = false

func hide_level_select():
	NoTouchRect.visible = true
	animation_player.play_backwards("ShowLevelSelect")
	await animation_player.animation_finished
	NoTouchRect.visible = false

func on_level_button_pressed():
	var button = group.get_pressed_button()
	
	await hide_level_select()
	
	Global.current_level_name = button.item_name
	Global.set_time(button.item_id)
	get_tree().change_scene_to_file("res://Game/Main/Scenes/game.tscn")
