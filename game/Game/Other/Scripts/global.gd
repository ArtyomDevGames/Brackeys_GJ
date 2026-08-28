extends Node

var is_paused = false

var Player_name = "User"
var PC_user_name = "User"

var current_money_amount = 0

var current_level_id : int
var current_level_name : String
var current_day : int = 28 + current_level_id

var current_scene : String
var is_scene_credits : bool = false

func set_time(day):
	current_level_id = day
	current_day = 28 + current_level_id
	
	Taskbar.set_time()
