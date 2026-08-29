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
const user_amount : Array = [3, 5, 7]

const user_name_list = "Names"

var user_state_id : int
const user_states : Array = ["ACTIVE", "DECIDE", "ACCEPTED", "DENIED", "REPORTED"]

const message_type = ["User", "Player"]
const questions = ["Why are you interested in this item?", "Have you read the description?", "Are you satisfied with the price?"]

const user_types_chances = [[70, 80, 100], [65, 80, 100], [60, 75, 100]]

# Для базы данных
const user_types = ["Basic", "Troll", "Scammer"]

const phrases = ["Opening_phrase", "First_question", "Second_question", "Last_phrase"]

const desc = "Profile_description"
const date = "Registration_date"


const basic_offered_price = [-0.2, 0.15]
const troll_offered_price = [-1, 1]
const scammer_offered_price = [0.3, 0.7]

# Данные уровня
var current_level_id : int
var current_level_name : String
var current_level_state : Array = [3, 0, 0]

const prices : Array = [30, 50, 100]

var current_day : int = 28 + current_level_id

# Окно статистики
var stats_title = "DAY RESULTS"
var who_sold_to : int
var money_recieved : int
var comment = ["\nNothing special", "\nWow... You actually sold them something", "\nYou've been scammed. Try better next time"]

# Итоговая статистика
var total_basic : int = 0
var total_trolls : int = 0
var total_scammers : int = 0
var total_rejected : int = 0
var total_reported : int = 0

var end_comment = ["\nNo money. How you even managed to do this?", "\nNot enough. Your wallet has chosen violence.", "\nEnough! Against all odds, you can actually afford the trip.", "\nWay more than needed. Are you selling your entire house next?"]

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
