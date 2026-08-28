extends CanvasLayer

@onready var name_label: Label = $ScrollContainer/Control/BackPanel/Panel/NameLabel
@onready var money_label: Label = $ScrollContainer/Control/BackPanel/Panel2/MoneyLabel


func _ready() -> void:
	name_label.text = Global.Player_name
	money_label.text = money_label.text.format([Global.current_money_amount], "[]")
	
