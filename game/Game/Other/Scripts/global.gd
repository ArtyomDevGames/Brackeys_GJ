extends Node

var is_paused = false

# Данные пользователя (игрока)
var Player_name = "User"
var PC_user_name = "User"

var current_money_amount = 0

# Покупатели
var users : Array = []
const user_amount : Array = [2, 3, 5]
const user_name_list : Array = ["Name1", "Name2", "Name3", "Name4", "Name5", "Name6", "Name7", "Name8", "Name9", "Name10"]

var user_state_id : int
const user_states : Array = ["Accepted", "Denied", "Reported"]

const user_types = ["Basic", "Troll", "Scammer"]
const basic_phrases = [[], [], []]
const troll_phrases = [[], [], []]
const scammer_phrases = [[], [], []]

const basic_offered_price = [-0.2, 0.15]
const troll_offered_price = [-0.5, 0.5]
const scammer_offered_price = [-0.3, 0.4]

# Данные уровня
var current_level_id : int
var current_level_name : String
var current_level_state : int

const prices : Array = [30, 50, 100]

var current_day : int = 28 + current_level_id

var current_scene : String
var is_scene_credits : bool = false

func set_time(day):
	current_level_id = day
	current_day = 28 + current_level_id
	
	Taskbar.set_time()

func what_price_range(id) -> Array:
	match id:
		0: return basic_offered_price
		1: return troll_offered_price
		2: return scammer_offered_price
	
	return [-0.1, 0.1]
