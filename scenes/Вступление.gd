extends Node2D

@onready var progress = 0
@onready var my_label = $Text1
var pc = 0

	
func _on_timer_timeout():
	if $Text1.visible_ratio == 1.0:
		progress += 1
		$Text1/Timer.stop()
	else:
		$Text1.visible_ratio += pc

func _ready():
	$Text1.visible_ratio = 0.0
	$Text1/Timer.start()
	my_label.text = "Гоблины и люди\n Их вражда никогда не закончится \n"
	pc = 1.0/my_label.text.length()

func _process(_delta):
	if progress == 1:
		$Text1.visible_ratio = 1.0
		my_label.text = "Гоблины и люди. Их вражда никогда не закончится"
	if progress == 3:
		$Text1.visible_ratio = 1.0
		my_label.text = "Если здесь будет другой текст, то я буду ссаться кипятком от радости"
	elif progress == 5:
		$Text1.visible_ratio = 1.0
		my_label.text = "Неужто это работает и у меня получилось..."
	elif progress == 7:
		$Text1.visible_ratio = 1.0
		my_label.text = "Ну раз так, тогда начнем"

func _on_button_pressed():
	progress += 1
	if progress == 2:
		$Text1/Timer.start()
		$Text1.visible_ratio = 0.0
		my_label.text = "Если здесь будет другой текст, то я буду ссаться кипятком от радости"
		pc = 1.0/my_label.text.length()
	elif progress == 4:
		$Text1/Timer.start()
		$Text1.visible_ratio = 0.0
		my_label.text = "Неужто это работает и у меня получилось..."
		pc = 1.0/my_label.text.length()
	elif progress == 6:
		$Text1/Timer.start()
		$Text1.visible_ratio = 0.0
		my_label.text = "Ну раз так, тогда начнем"
		pc = 1.0/my_label.text.length()
	elif progress == 8:
		get_tree().change_scene_to_file("res://scenes/All_lvl/Lvl_1/lvl_1.tscn")

