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
		my_label.text = "Гоблины и люди\n Их вражда никогда не закончится \n"
	if progress == 3:
		$Text1.visible_ratio = 1.0
		my_label.text = "Для гоблинов это поиск наживы и развлечение, а вот для людей вопрос выживания"
	elif progress == 5:
		$Text1.visible_ratio = 1.0
		my_label.text = "Но у людей есть козырь \n Это четверо отважных героев защищающих людской покой"
	elif progress == 7:
		$Text1.visible_ratio = 1.0
		my_label.text = "И об одном из них будет наша история"

func _on_button_pressed():
	progress += 1
	if progress == 2:
		$Text1/Timer.start()
		$Text1.visible_ratio = 0.0
		my_label.text = "Для гоблинов это поиск наживы и развлечение, а вот для людей вопрос выживания"
		pc = 1.0/my_label.text.length()
	elif progress == 4:
		$Text1/Timer.start()
		$Text1.visible_ratio = 0.0
		my_label.text = "Но у людей есть козырь \n Это четверо отважных героев защищающих людской покой"
		pc = 1.0/my_label.text.length()
	elif progress == 6:
		$Text1/Timer.start()
		$Text1.visible_ratio = 0.0
		my_label.text = "И об одном из них будет наша история"
		pc = 1.0/my_label.text.length()
	elif progress == 8:
		get_tree().change_scene_to_file("res://scenes/All_lvl/Lvl_1/lvl_1.tscn")

