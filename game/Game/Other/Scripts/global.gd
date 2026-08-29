extends Node

var is_paused = false

# Данные пользователя (игрока)
var Player_name = "User"
var PC_user_name = "User"

var current_money_amount = 0

# Сотрудник поддержки
const support_phrases = "Support"

# Покупатели
var users : Array = []
const user_amount : Array = [2, 3, 5]

const user_name_list = "Names"

var user_state_id : int
const user_states : Array = ["Active", "Decide", "Accepted", "Denied", "Reported"]

const message_type = ["User", "Player"]
const questions = ["Why are you interested in this item?", "Have you read the description?", "Are you satisfied with the price?"]

const user_types_chances = [[70, 80, 100], [65, 80, 100], [60, 75, 100]]

# Для базы данных
const user_types = ["Basic", "Troll", "Scammer"]

const phrases = ["Opening_phrase", "First_question", "Second_question", "Last_phrase"]

const desc = "Profile_description"
const date = "Registration_date"


const basic_offered_price = [-0.2, 0.15]
const troll_offered_price = [-0.5, 0.5]
const scammer_offered_price = [0.3, 0.7]

# Данные уровня
var current_level_id : int
var current_level_name : String
var current_level_state : int

const prices : Array = [30, 50, 100]

var current_day : int = 28 + current_level_id

func set_time(day):
	current_level_id = day
	current_day = 28 + current_level_id
	
	Taskbar.set_time()

func what_price_range(customer_id) -> Array:
	match customer_id:
		0: return basic_offered_price
		1: return troll_offered_price
		2: return scammer_offered_price
	
	return [-0.1, 0.1]

func what_user_chance() -> Array:
	return user_types_chances[current_level_id]
