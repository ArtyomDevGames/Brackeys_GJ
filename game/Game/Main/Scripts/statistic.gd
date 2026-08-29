extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var stats_label: Label = $ScrollContainer/Control/BackPanel/Top/StatLabel

@onready var sold_to_label: RichTextLabel = $ScrollContainer/Control/BackPanel/Panel/DayEnded/SoldToLabel
@onready var money_received_label: RichTextLabel = $ScrollContainer/Control/BackPanel/Panel/DayEnded/MoneyReceivedLabel

@onready var day_ended: VBoxContainer = $ScrollContainer/Control/BackPanel/Panel/DayEnded
@onready var stats: VBoxContainer = $ScrollContainer/Control/BackPanel/Panel/Stats

@onready var basic: RichTextLabel = $ScrollContainer/Control/BackPanel/Panel/Stats/basic
@onready var troll: RichTextLabel = $ScrollContainer/Control/BackPanel/Panel/Stats/troll
@onready var scam: RichTextLabel = $ScrollContainer/Control/BackPanel/Panel/Stats/scam
@onready var reject: RichTextLabel = $ScrollContainer/Control/BackPanel/Panel/Stats/reject
@onready var report: RichTextLabel = $ScrollContainer/Control/BackPanel/Panel/Stats/report
@onready var mo_ne_y: RichTextLabel = $ScrollContainer/Control/BackPanel/Panel/Stats/MoNeY


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	stats_label.text = Global.stats_title
	
	if stats_label.text == "DAY RESULTS":
		day_ended.visible = true
		sold_to_label.text = "You have sold your item to: \n[wave]{}[/wave]".format([Global.user_types[Global.who_sold_to]], "{}") + Global.comment[Global.who_sold_to]
		money_received_label.text = "Money received: \n[color=#64BC6D][wave]${}[/wave][/color]".format([Global.money_recieved], "{}")
	else:
		$ScrollContainer/Control/BackPanel/Panel/NextDayButton.button_text = "TO CREDITS"
		$ScrollContainer/Control/BackPanel/Panel/NextDayButton.set_button_text()
		
		stats.visible = true
		basic.text = basic.text.format([Global.total_basic], "{}")
		troll.text = troll.text.format([Global.total_trolls], "{}")
		scam.text = scam.text.format([Global.total_scammers], "{}")
		reject.text = reject.text.format([Global.total_rejected], "{}")
		report.text = report.text.format([Global.total_reported], "{}")
		
		var comment : String
		
		if Global.current_money_amount == 0: comment = Global.end_comment[0]
		elif Global.current_money_amount < 180: comment = Global.end_comment[1]
		elif 180 <= Global.current_money_amount and Global.current_money_amount < 200: comment = Global.end_comment[2]
		else: comment = Global.end_comment[3]
		
		mo_ne_y.text = "Total [color=#64BC6D][wave]MoNeY[/wave][/color] earned: \n[color=#64BC6D][wave]${}[/wave][/color]".format([Global.current_money_amount], "{}") + comment
	
	show_menu()


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


func _on_next_day_button_pressed() -> void:
	await hide_menu()
	
	if stats_label.text == "DAY RESULTS":
		match Global.who_sold_to:
			0:
				Global.current_level_state[Global.current_level_id] = 1
			1:
				Global.current_level_state[Global.current_level_id] = 1
			2: 
				Global.current_level_state[Global.current_level_id] = 2
		
		Global.current_level_state[Global.current_level_id + 1] = 3
		
		get_tree().change_scene_to_file("res://Game/Main/Scenes/level_select.tscn")
	else:
		get_tree().change_scene_to_file("res://Game/Main/Scenes/credits.tscn")
