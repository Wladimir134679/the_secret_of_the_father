extends Node2D

var full_text: String
var character_pos: int = 0
var progress = 0
@onready var my_label = $Text1

func set_text(new_text:String):
	full_text = new_text
	character_pos = 0

func _on_timer_timeout():
	character_pos += 1
	var text = full_text.substr(0, character_pos)
	if character_pos == full_text.length():
		$Text1/Timer.stop()
		

func _ready():
	my_label.text = "Здесь будет очень много текста и когда-нибудь ахуенные диалоги:)"

func _process(_delta):
	pass

func _on_button_pressed():
	progress += 1
	if progress == 1:
		my_label.text = "Если здесь будет другой текст, то я буду ссаться кипятком от радости"
	elif progress == 2:
		my_label.text = "Неужто это работает и у меня получилось..."
	elif progress == 3:
		my_label.text = "Ну раз так, тогда начнем"
	elif progress == 4:
		get_tree().change_scene_to_file("res://scenes/test_world.tscn")

