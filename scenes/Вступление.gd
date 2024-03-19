extends Node2D

var pc = 0.015
var progress = 0
@onready var my_label = $Text1

	
func _on_timer_timeout():
	if $Text1.visible_ratio == 0.99:
		$Timer.stop()
	else:
		$Text1.visible_ratio += pc

func _ready():
	$Text1.visible_ratio = 0.0
	$Text1/Timer.start()
	my_label.text = "Здесь будет очень много текста и когда-нибудь ахуенные диалоги:)"

func _process(_delta):
	pass

func _on_button_pressed():
	progress += 1
	if progress == 1:
		$Text1.visible_ratio = 0.0
		my_label.text = "Если здесь будет другой текст, то я буду ссаться кипятком от радости"
	elif progress == 2:
		$Text1.visible_ratio = 1.0
		my_label.text = "Если здесь будет другой текст, то я буду ссаться кипятком от радости"
	elif progress == 3:
		$Text1.visible_ratio = 0.0
		my_label.text = "Неужто это работает и у меня получилось..."
	elif progress == 4:
		$Text1.visible_ratio = 1.0
		my_label.text = "Неужто это работает и у меня получилось..."
	elif progress == 5:
		$Text1.visible_ratio = 0.0
		my_label.text = "Ну раз так, тогда начнем"
	elif progress == 6:
		$Text1.visible_ratio = 1.0
		my_label.text = "Ну раз так, тогда начнем"
	elif progress == 7:
		get_tree().change_scene_to_file("res://scenes/test_world.tscn")

