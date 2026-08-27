extends CanvasLayer

@onready var item_name_label: Label = $ScrollContainer/Control/Top/ItemNameLabel

func _ready() -> void:
	item_name_label.text = Global.current_level_name


func _process(delta: float) -> void:
	pass
