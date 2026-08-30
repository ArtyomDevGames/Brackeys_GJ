extends Button

@export_range(0, 3) var item_state_id : int # Это за иконку статуста уровня
@export_range(0, 2) var item_id : int # Это за картинку (уровень по порядку)
@export var item_name : String # Это за название уровня

@onready var state_icon: AnimatedSprite2D = $Panel/StateIcon
@onready var item_name_label: Label = $Panel/ItemNameLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var item_icon: AnimatedSprite2D = $Panel/ItemIcon

func _ready() -> void:
	set_item_name()
	set_item_state_icon()
	set_item_icon()

func set_item_name() -> void:
	item_name_label.text = item_name

func set_item_icon() -> void:
	item_icon.frame = item_id

func set_item_state_icon() -> void:
	if item_state_id != 3: 
		state_icon.visible = true
		state_icon.frame = item_state_id
		disabled = true
	else:
		state_icon.visible = false
		disabled = false


func _on_mouse_entered() -> void:
	if item_state_id == 3: animation_player.play("Hover")

func _on_mouse_exited() -> void:
	if item_state_id == 3: animation_player.play_backwards("Hover")
