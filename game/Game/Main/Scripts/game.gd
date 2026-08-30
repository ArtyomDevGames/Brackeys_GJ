extends CanvasLayer

# База
var dialogue_data : Dictionary

const dialogue_path = "res://Assets/Database/dialogue_phrases.json"

# Остальное
@export var group : ButtonGroup
@export var decision_group : ButtonGroup

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var message_timer: Timer = $MessageTimer

const user = preload("res://Game/UI/Scenes/user_button.tscn")

# Элементы товара
@onready var item_icon: AnimatedSprite2D = $BackPanel/Top/ItemIcon
@onready var item_name_label: Label = $BackPanel/Top/ItemNameLabel
@onready var item_price: RichTextLabel = $BackPanel/Top/ItemPrice

# Элементы верхней панели меню чата
@onready var icon_frame: AnimatedSprite2D = $BackPanel/Background/Top/IconFrame
@onready var user_name_label: Label = $BackPanel/Background/Top/UserNameLabel
@onready var custom_button: Button = $BackPanel/Background/Top/CustomButton

var is_chat_selected = false
var is_profile_visible = false

# Чат
@onready var chat_container: ScrollContainer = $BackPanel/Background/ChatContainer
@onready var chat: VBoxContainer = $BackPanel/Background/ChatContainer/Chat
const customer_responce = preload("res://Game/UI/Scenes/user_reply.tscn")
const player_message = preload("res://Game/UI/Scenes/player_message.tscn")

# Кнопочки с покупателями
@onready var buttons: VBoxContainer = $BackPanel/ScrollContainer/Control/Panel/Buttons

# Элементы нижней панели меню чата
@onready var choice_buttons: HBoxContainer = $BackPanel/Background/Bottom/ChoiceButtons
@onready var choice: Button = $BackPanel/Background/Bottom/ChoiceButtons/Choice

@onready var text_line: LineEdit = $BackPanel/Background/Bottom/TextLine
@onready var send: Button = $BackPanel/Background/Bottom/Send
@onready var decide: Button = $BackPanel/Background/Bottom/Decide


# Для профиля инфа
var current_user_name : String
var current_user_icon : int
var current_user_id : int

func _ready() -> void:
	item_icon.frame = Global.current_level_id
	
	Global.users = []
	$Decision.pressed.connect(hide_decision)
	
	var file = FileAccess.open(dialogue_path, FileAccess.READ)
	dialogue_data = JSON.parse_string(file.get_as_text())
	
	item_name_label.text = Global.current_level_name
	item_price.text = item_price.text.format([Global.prices[Global.current_level_id]], "{}")
	
	await show_menu()
	
	if Global.current_level_id == 0:
		var support_phrases = []
		
		for row in dialogue_data["Support"]["rows"]:
			support_phrases.append(row["Phrase"])
		
		var support = {
			"user_id" : 0,
			"user_name" : "DaveNotTheDiver",
			"user_type_id": 2,
			"user_type" : Global.user_types[2],
			"user_icon" : 0,
			"user_description" : "Helping everybody just because I can",
			"user_date" : "2026.08.30",
			"phrases" : support_phrases,
			"current_question": 0,
			"current_phrase": 0,
			"dialogue" : [{"Phrase": support_phrases[0], "Type" : Global.message_type[0]}],
			"offered_price" : 0,
			"user_state" : 0
		}
		
		Global.users.append(support)
		add_user_buttons(0)
		
		for i in range(1, Global.user_amount[Global.current_level_id]):
			create_user(i)
			add_user_buttons(i)
			
			buttons.get_child(i).disabled = true
	else:
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

# Кнопки жмаются
func _on_custom_button_pressed() -> void:
	Profile.set_user_icon(current_user_icon)
	Profile.set_user_name(current_user_name)
	Profile.set_user_registration(Global.users[current_user_id]["user_date"])
	Profile.set_user_description(Global.users[current_user_id]["user_description"])
	Profile.visible = true
	is_profile_visible = true

func button_pressed() -> void:
	chat_container.scroll_vertical = 0
	
	var button = group.get_pressed_button()
	var customer = Global.users[button.user_id]
	
	if is_chat_selected == false:
		is_chat_selected = true
		
		icon_frame.visible = true
		user_name_label.visible = true
		custom_button.visible = true
	
	if customer["user_state"] == 0:
		decide.visible = false
		choice_buttons.visible = true
		text_line.visible = true
		send.visible = true
		
		text_line.text = ""
		choice.visible = true
		send.disabled = true
	elif customer["user_state"] == 1:
		choice_buttons.visible = false
		text_line.visible = false
		send.visible = false
		decide.visible = true
		decide.disabled = false
		decide.text = "DECIDE"
	
	if customer["user_state"] > 1:
		decide.text = Global.user_states[customer["user_state"]]
		decide.visible = true
		decide.disabled = true
		choice_buttons.visible = false
		text_line.visible = false
		send.visible = false
		
	
	
	icon_frame.frame = button.user_icon_id
	user_name_label.text = button.user_name
	
	current_user_id = button.user_id
	current_user_icon = button.user_icon_id
	current_user_name = button.user_name
	
	var current_question = Global.questions[Global.users[button.user_id]["current_question"]]
	
	choice.button_text = current_question
	choice.set_button_text()
	
	show_chat(button.user_id)

func decision_pressed() -> void:
	var button = decision_group.get_pressed_button()
	var state : int
	
	
	if button.button_name == "AcceptButton":
		state = 2
		show_sure(state)
	elif button.button_name == "DeclineButton":
		state = 3
		show_sure(state)
	elif button.button_name == "ReportButton":
		state = 4
		show_sure(state)
	
	if button.button_name == "NoButton":
		hide_sure()
		hide_decision()
	elif button.button_name == "YesButton":
		match button.decision:
			2:
				Global.who_sold_to = Global.users[current_user_id]["user_type_id"]
				if Global.who_sold_to != 2:
					Global.money_recieved = Global.users[current_user_id]["offered_price"]
					Global.current_money_amount += Global.money_recieved
				$EndDayButton.visible = true
			3:
				Global.total_rejected += 1
			4:
				Global.total_reported += 1
		
		Global.users[current_user_id]["user_state"] = button.decision
		
		decide.disabled = true
		decide.text = Global.user_states[button.decision]
		
		hide_sure()
		hide_decision()

func _on_end_day_button_pressed() -> void:
	$EndDayButton.visible = false
	await hide_menu()
	
	if Global.current_level_id == 2: Global.stats_title = "SUMMARY STATISTICS"
	
	get_tree().change_scene_to_file("res://Game/Main/Scenes/statistic.tscn")


func show_sure(decision : int):
	$Decision/Panel/Label1.visible = false
	$Decision/Panel/VBoxContainer.visible = false
	$Decision/Panel/AreYouSure.visible = true
	$Decision/Panel/Label.visible = true
	
	$Decision/Panel/AreYouSure/CustomButton.decision = decision
	$Decision/Panel/AreYouSure/CustomButton2.decision = decision

func hide_sure():
	$Decision/Panel/Label1.visible = true
	$Decision/Panel/VBoxContainer.visible = true
	$Decision/Panel/AreYouSure.visible = false
	$Decision/Panel/Label.visible = false

func choice_pressed():
	text_line.text = choice.button_text
	choice.visible = false
	send.disabled = false

func send_pressed():
	send.disabled = true
	var customer = Global.users[current_user_id]
	
	for child in buttons.get_children():
		child.disabled = true
	
	custom_button.disabled = true
	
	
	if customer["user_state"] != 1:
		if customer["current_question"] < 2: customer["current_question"] += 1
		customer["current_phrase"] += 1
		
		var bubble = show_message({"Phrase": text_line.text, "Type": "Player"})
		await bubble.show_message()
		customer["dialogue"].append({"Phrase": text_line.text, "Type": "Player"})
		text_line.text = ""
		message_timer.start(0.5)
		await message_timer.timeout
		
		if customer["current_phrase"] == 3 and "XX" in customer["phrases"][customer["current_phrase"]]:
			customer["phrases"][customer["current_phrase"]] = customer["phrases"][customer["current_phrase"]].format([customer["offered_price"]], "XX")
		
		bubble = show_message({"Phrase": customer["phrases"][customer["current_phrase"]], "Type": "User"})
		await bubble.show_message()
		bubble.play_sound()
		customer["dialogue"].append({"Phrase": customer["phrases"][customer["current_phrase"]], "Type": "User"})
		message_timer.start(1)
		await message_timer.timeout
		
		if customer["current_phrase"] == 3:
			if Global.current_level_id == 0 and customer["user_id"] == 0:
				message_timer.start(1.5)
				await message_timer.timeout
				for i in range(4, customer["phrases"].size()):
					customer["current_phrase"] = i
					bubble = show_message({"Phrase": customer["phrases"][customer["current_phrase"]], "Type": "User"})
					await bubble.show_message()
					bubble.play_sound()
					customer["dialogue"].append({"Phrase": customer["phrases"][customer["current_phrase"]], "Type": "User"})
					message_timer.start(2)
					await message_timer.timeout
				
				
				for i in range(1, Global.user_amount[Global.current_level_id]):
					buttons.get_child(i).disabled = true
			
			customer["user_state"] = 1
	
	if customer["user_state"] == 1:
		choice_buttons.visible = false
		text_line.visible = false
		send.visible = false
		decide.visible = true
		decide.disabled = false
		decide.text = "DECIDE"
	else:
		var current_question = Global.questions[customer["current_question"]]
	
		choice.button_text = current_question
		choice.set_button_text()
		
		choice_buttons.visible = true
		text_line.visible = true
		send.visible = true
		
		text_line.text = ""
		choice.visible = true
		send.disabled = true
	
	
	for child in buttons.get_children():
		child.disabled = false
	
	if Global.current_level_id == 0 and customer["user_id"] == 0 and customer["user_state"] != 1:
		for i in range(1, Global.user_amount[Global.current_level_id]):
			buttons.get_child(i).disabled = true
	
	custom_button.disabled = false

func _on_decide_pressed() -> void:
	$Decision.visible = true
	
	var is_accepted : bool = false
	var total_decided : int = 0
	var total_accepted : int = 0
	for thing in Global.users:
		if thing["user_state"] == 2:
			is_accepted = true
			total_accepted += 1
		if thing["user_state"] != 1 and thing["user_state"] != 0:
			total_decided += 1
	
	if is_accepted == false and total_decided == Global.users.size() - 1:
		$Decision/Panel/VBoxContainer/CustomButton2.disabled = true
		$Decision/Panel/VBoxContainer/CustomButton3.disabled = true
		$Decision/Panel/AreYouSure/CustomButton2.disabled = true
	
	if total_accepted >= 1:
		$Decision/Panel/VBoxContainer/CustomButton.disabled = true

func hide_decision():
	$Decision.visible = false
	
	$Decision/Panel/VBoxContainer/CustomButton.disabled = false
	$Decision/Panel/VBoxContainer/CustomButton2.disabled = false
	$Decision/Panel/VBoxContainer/CustomButton3.disabled = false
	$Decision/Panel/AreYouSure/CustomButton2.disabled = false
	$Decision/Panel/AreYouSure/CustomButton.disabled = false

# Пользовательские штуки
func create_user(id : int) -> void:
	var icon_id = randi_range(0, 6) # Для выбора иконки
	var random_number = randi_range(0, 100) # Для выбора типа
	var type_id : int
	var customer_chance = Global.what_user_chance()
	
	if random_number <= customer_chance[0]:
		type_id = 0
		Global.total_basic += 1
	elif customer_chance[0] < random_number and random_number <= customer_chance[1]:
		type_id = 1
		Global.total_trolls += 1
	else:
		type_id = 2
		Global.total_scammers += 1
	
	var type = Global.user_types[type_id]
	
	var user_phrases = [
			generate_user_info(type, Global.phrases[0]),
			generate_user_info(type, Global.phrases[1]),
			generate_user_info(type, Global.phrases[2]),
			generate_user_info(type, Global.phrases[3])
		]
		
	var new_user = {
		"user_id" : id,
		"user_name" : get_random_name(),
		"user_type_id": type_id,
		"user_type" : type,
		"user_icon" : icon_id,
		"user_description" : generate_user_info(type, Global.desc),
		"user_date" : generate_user_info(type, Global.date),
		"phrases" : user_phrases,
		"current_question": 0,
		"current_phrase": 0,
		"dialogue" : [{"Phrase": user_phrases[0], "Type" : Global.message_type[0]}],
		"offered_price" : count_offered_price(type_id),
		"user_state" : 0
	}
	
	Global.users.append(new_user)

func get_random_name() -> String:
	var names = dialogue_data["Names"]["rows"]
	return str(names.pick_random()["Name"]).strip_edges()

func count_offered_price(customer_id : int) -> int:
	var current_price = Global.prices[Global.current_level_id]
	
	var price_range = Global.what_price_range(customer_id)
	var min_price : int = price_range[0] * current_price + current_price
	var max_price : int = price_range[1] * current_price + current_price
	
	var new_price = randi_range(min_price, max_price)
	
	return new_price

func generate_user_info(customer_type : String, info_name : String) -> String:
	var rows = dialogue_data[customer_type]["rows"]
	var random_row = rows.pick_random()
	
	return str(random_row[info_name]).strip_edges()

func add_user_buttons(id : int) -> void:
	var customer = user.instantiate()
	
	customer.user_id = Global.users[id]["user_id"]
	customer.user_name = Global.users[id]["user_name"]
	customer.user_icon_id = Global.users[id]["user_icon"]
	
	buttons.add_child(customer)


# Штуки чата
func show_chat(customer_id : int) -> void:
	for message in chat.get_children():
		message.queue_free()
	
	await get_tree().process_frame
	
	var chat_lenght = Global.users[customer_id]["dialogue"].size()
	
	for i in range(chat_lenght):
		var bubble = show_message(Global.users[customer_id]["dialogue"][i])
		bubble.show_message()
		if chat_lenght == 1: bubble.play_sound()

func show_message(message : Dictionary) -> Control:
	var chat_bubble
	
	match message["Type"]:
		"User": chat_bubble = customer_responce.instantiate()
		"Player": chat_bubble = player_message.instantiate()
	
	chat_bubble.text = message["Phrase"]
	chat.add_child(chat_bubble)
	
	return chat_bubble
