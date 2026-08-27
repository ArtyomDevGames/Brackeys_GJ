extends CanvasLayer

@export var group : ButtonGroup

# Элементы товара
@onready var item_name_label: Label = $BackPanel/Top/ItemNameLabel

# Элементы верхней панели меню чата
@onready var icon_frame: AnimatedSprite2D = $BackPanel/Background/Top/IconFrame
@onready var user_name_label: Label = $BackPanel/Background/Top/UserNameLabel
@onready var custom_button: Button = $BackPanel/Background/Top/CustomButton

var is_top_visible = false
var is_profile_visible = false

# Кнопочки с покупателями
@onready var buttons: VBoxContainer = $BackPanel/ScrollContainer/Control/Panel/Buttons


# Для профиля инфа
var current_user_name : String
var current_user_id : int

var questions : int = 3

func _ready() -> void:
	item_name_label.text = Global.current_level_name
	
	for child in buttons.get_children():
		child.button_group = group
		child.pressed.connect(button_pressed)
	


func _process(delta: float) -> void:
	pass


func _on_custom_button_pressed() -> void:
	Profile.set_user_icon(current_user_id)
	Profile.set_user_name(current_user_name)
	Profile.visible = true
	is_profile_visible = true

func button_pressed() -> void:
	var button = group.get_pressed_button()
	
	if is_top_visible == false:
		is_top_visible = true
		
		icon_frame.visible = true
		user_name_label.visible = true
		custom_button.visible = true
	
	icon_frame.frame = button.user_icon_id
	user_name_label.text = button.user_name
	
	current_user_id = button.user_icon_id
	current_user_name = button.user_name
