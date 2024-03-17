extends Node2D

var progress = 0
@onready var my_label = $Text1

func _ready():
	pass

func _process(_delta):
	pass

func _on_button_pressed():
	progress += 1
	if progress == 1:
		my_label.text = "Здесь будет очень много текста и когда-нибудь ахуенные диалоги:)"
	elif progress == 2:
		my_label.text = "Если здесь будет другой текст, то я буду ссаться кипятком от радости"
	elif progress == 3:
		my_label.text = "Неужто это работает и у меня получилось..."
	elif progress == 4:
		my_label.text = "Ну раз так, тогда начнем"
	elif progress == 5:
		get_tree().change_scene_to_file("res://scenes/test_world.tscn")
		
