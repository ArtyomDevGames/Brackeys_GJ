extends CanvasLayer

var database : SQLite

@export var group : ButtonGroup

@onready var animation_player: AnimationPlayer = $AnimationPlayer

const user = preload("res://Game/UI/Scenes/user_button.tscn")

# Элементы товара
@onready var item_name_label: Label = $BackPanel/Top/ItemNameLabel
@onready var item_price: RichTextLabel = $BackPanel/Top/ItemPrice

# Элементы верхней панели меню чата
@onready var icon_frame: AnimatedSprite2D = $BackPanel/Background/Top/IconFrame
@onready var user_name_label: Label = $BackPanel/Background/Top/UserNameLabel
@onready var custom_button: Button = $BackPanel/Background/Top/CustomButton
@onready var offered_price: RichTextLabel = $BackPanel/Background/Top/OfferedPrice
@onready var label: Label = $BackPanel/Background/Top/Label

var is_chat_selected = false
var is_profile_visible = false

# Чат
@onready var chat: VBoxContainer = $BackPanel/Background/ScrollContainer2/Chat

# Кнопочки с покупателями
@onready var buttons: VBoxContainer = $BackPanel/ScrollContainer/Control/Panel/Buttons

# Элементы нижней панели меню чата
@onready var choice_buttons: HBoxContainer = $BackPanel/Background/Bottom/ChoiceButtons
@onready var option_1_button: Button = $BackPanel/Background/Bottom/ChoiceButtons/CustomButton
@onready var text_line: LineEdit = $BackPanel/Background/Bottom/TextLine
@onready var send_button: Button = $BackPanel/Background/Bottom/CustomButton

# Для профиля инфа
var current_user_name : String
var current_user_id : int

var questions : int = 3

func _ready() -> void:
	database = SQLite.new()
	database.path = "res://Assets/Database/dialogue_phrases.db"
	database.open_db()
	
	database.query("select * from {}".format([Global.support_phrases], "{}"))
	var data = database.query_result
	print(data)
	
	await show_menu()
	
	item_name_label.text = Global.current_level_name
	item_price.text = item_price.text.format([Global.prices[Global.current_level_id]], "{}")
	
	if Global.users.is_empty() == false:
		print("Не, не надо человеков")
		for i in range(Global.user_amount[Global.current_level_id]):
			add_user_buttons(i)
	else:
		print("Надо человеков")
		for i in range(Global.user_amount[Global.current_level_id]):
			create_user(i)
			add_user_buttons(i)
	
	for child in buttons.get_children():
		child.button_group = group
		child.pressed.connect(button_pressed)
		await child.show_button()

func show_menu():
	NoTouchRect.visible = true
	animation_player.play("ShowMenu")
	await animation_player.animation_finished
	NoTouchRect.visible = false

func hide_menu():
	NoTouchRect.visible = true
	animation_player.play_backwards("ShowMenu")
	await animation_player.animation_finished
	NoTouchRect.visible = false

func _on_custom_button_pressed() -> void:
	Profile.set_user_icon(current_user_id)
	Profile.set_user_name(current_user_name)
	Profile.visible = true
	is_profile_visible = true

func button_pressed() -> void:
	var button = group.get_pressed_button()
	
	print("Пользователь: ", Global.users[button.user_id]["user_type"])
	
	
	if is_chat_selected == false:
		is_chat_selected = true
		
		icon_frame.visible = true
		user_name_label.visible = true
		custom_button.visible = true
		offered_price.visible = true
		label.visible = true
		
		choice_buttons.visible = true
		text_line.visible = true
		send_button.visible = true
	
	
	icon_frame.frame = button.user_icon_id
	user_name_label.text = button.user_name
	offered_price.text = "	[color=GREEN][wave]{}$[/wave][/color]".format([Global.users[button.user_id]["offered_price"]], "{}")
	
	current_user_id = button.user_icon_id
	current_user_name = button.user_name
	
	for message in chat.get_children(): await message.show_message()


func create_user(id : int) -> void:
	var name_id = randi_range(0, 9)
	
	var random_number = randi_range(0, 100)
	var type_id : int
	var customer_chance = Global.what_user_chance()
	
	if random_number <= customer_chance[0]: type_id = 0
	elif customer_chance[0] < random_number and random_number <= customer_chance[1]: type_id = 1
	else: type_id = 2
	
	var user_offered_price = count_offered_price(type_id)
	
	var new_user = {
		"user_id" : id,
		"user_name" : Global.user_name_list[name_id],
		"user_type" : Global.user_types[type_id],
		"user_icon" : 0,
		"user_description" : "damn" + str(id),
		"user_date" : Global.current_day,
		"phrases" : ["phrase1", "phrase2", "phrase3", "phrase4"],
		"current_phrase" : 0,
		"offered_price" : user_offered_price,
		"user_state" : 0
	}
	
	Global.users.append(new_user)

func count_offered_price(user_type) -> int:
	var current_price = Global.prices[Global.current_level_id]
	
	var price_range = Global.what_price_range(user_type)
	var min_price : int = price_range[0] * current_price + current_price
	var max_price : int = price_range[1] * current_price + current_price
	
	var new_price = randi_range(min_price, max_price)
	
	return new_price

func add_user_buttons(id : int) -> void:
	var customer = user.instantiate()
	
	customer.user_id = Global.users[id]["user_id"]
	customer.user_name = Global.users[id]["user_name"]
	customer.user_icon_id = Global.users[id]["user_icon"]
	
	buttons.add_child(customer)
