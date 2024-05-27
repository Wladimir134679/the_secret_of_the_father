extends Node2D

@onready var my_label = $"Автоматика сцены/CanvasGroup"/Text2
@onready var gobx = (3770 - $"3Death".position.x)/180
@onready var goby = (3900 - $"3Death".position.y)/180
@onready var progress = 0
@export var camera: Camera2D
@onready var Player = $WorldObjects/Player
@onready var DlinTxt = my_label.text.length()
var pc = 0

func _ready():
	pass 


func _process(delta):
	if progress == 0:
		$GoblinTower.process_mode = Node.PROCESS_MODE_DISABLED
		camera.position = Player.position
		camera.to_player = false
		$"3Death".process_mode = Node.PROCESS_MODE_DISABLED
		if camera.position.x != Player.position.x:
			camera.position.x += ((Player.position.x - camera.position.x)/50)
		if camera.position.y != Player.position.y:
			camera.position.y += ((Player.position.y - camera.position.y)/50)
	elif progress == 2:
		$"Автоматика сцены/CanvasGroup"/Text2.visible_ratio = 1.0
	elif progress == 4:
		$"Автоматика сцены/CanvasGroup"/Text2.visible_ratio = 1.0
	elif progress == 6:
		$"Автоматика сцены/CanvasGroup"/Text2.visible_ratio = 1.0
	elif progress == 7:
		Player.anim.play("Walk")
		$"Автоматика сцены/Button".process_mode = Node.PROCESS_MODE_DISABLED
		$"Автоматика сцены/CanvasGroup".visible = false
		if camera.position.x != Player.position.x:
			camera.position.x += ((Player.position.x - camera.position.x)/50)
		if camera.position.y != Player.position.y:
			camera.position.y += ((Player.position.y - camera.position.y)/50)
		if Player.position.x != 3500:
			Player.position.x += (3500 / 3144) * 2.5
		if Player.position.y != 3740:
			Player.position.y -= (3888 /3750) * 1.1
		if camera.position.y <= 3800:
			$Grid.visible = false
			$"Автоматика сцены/Button".process_mode = Node.PROCESS_MODE_INHERIT
			Player.anim.play("Idle")
			$"Автоматика сцены/CanvasGroup"/Text2.visible_ratio = 0.0
			$"Автоматика сцены/CanvasGroup"/Text2/Timer.start()
			my_label.text = "Что за странный кулон?"
			pc = 1.0/DlinTxt
			$"Автоматика сцены/CanvasGroup".visible = true
			progress += 1
	elif progress == 10:
		$"Автоматика сцены/CanvasGroup"/Text2.visible_ratio = 1.0
	elif progress == 12:
		$"Автоматика сцены/CanvasGroup"/Text2.visible_ratio = 1.0
	elif progress == 14:
		$"Автоматика сцены/CanvasGroup"/Text2.visible_ratio = 1.0
	elif progress == 16:
		$"Автоматика сцены/CanvasGroup"/Text2.visible_ratio = 1.0
	elif progress == 18:
		$"Автоматика сцены/CanvasGroup"/Text2.visible_ratio = 1.0
	elif progress == 20:
		$"Автоматика сцены/CanvasGroup"/Text2.visible_ratio = 1.0
	elif progress == 21:
		$"Автоматика сцены/Button".process_mode = Node.PROCESS_MODE_DISABLED
		$"Автоматика сцены/CanvasGroup".visible = false
		$"3Death/Goblin".anim.play("Walk")
		$"3Death/Goblin2".anim.play("Walk")
		$"3Death/Goblin3".anim.play("Walk")
		if $"3Death".position.x != 3770:
			$"3Death".position.x += gobx
		if $"3Death".position.y != 3900:
			$"3Death".position.y += goby
		if $"3Death".position.x <= 3800:
			$"3Death/Goblin".anim.play("Idle")
			$"3Death/Goblin2".anim.play("Idle")
			$"3Death/Goblin3".anim.play("Idle")
			$"Автоматика сцены/Button".process_mode = Node.PROCESS_MODE_INHERIT
			progress += 1
	elif progress == 22:
		$"3Death/Label".visible = true
		$"3Death/Label2".visible = true
		$"3Death/Label3".visible = true
		
func _on_timer_timeout():
	if $"Автоматика сцены/CanvasGroup"/Text2.visible_ratio == 1.0:
		if progress % 2 == 1:
			progress += 1
		elif progress == 8:
			progress += 2
		$"Автоматика сцены/CanvasGroup"/Text2/Timer.stop()
	else:
		$"Автоматика сцены/CanvasGroup"/Text2.visible_ratio += pc



func _on_button_pressed():
	progress += 1
	$"Автоматика сцены/CanvasGroup/Text2".visible_ratio = 0.0
	if progress == 1:
		camera.position.x = Player.position.x
		camera.position.y = Player.position.y
		$"Автоматика сцены/CanvasGroup"/Text2/Timer.start()
		$"Автоматика сцены/CanvasGroup".visible = true
		my_label.text = "Какой замечательный день, это путешествие определенно того стоило!"
		pc = 1.0/DlinTxt
	elif progress == 3:
		$"Автоматика сцены/CanvasGroup"/Text2/Timer.start()
		my_label.text = "Они даже не знают чего лишили себя"
		pc = 1.0/DlinTxt
	elif progress == 5:
		$"Автоматика сцены/CanvasGroup"/Text2/Timer.start()
		my_label.text = "Откуда этот странный голос?"
		pc = 1.0/DlinTxt
	elif progress == 11:
		$"Автоматика сцены/CanvasGroup"/Grid.visible = true
		$"Автоматика сцены/CanvasGroup"/Name2.visible = true
		$"Автоматика сцены/CanvasGroup"/Text2/Timer.start()
		my_label.text = "Что ты такое?"
		pc = 1.0/DlinTxt
	elif progress == 13:
		$"Автоматика сцены/CanvasGroup"/Name2.visible = true
		$"Автоматика сцены/CanvasGroup"/Грид.visible = true
		$"Автоматика сцены/CanvasGroup"/Син.visible = false
		$"Автоматика сцены/CanvasGroup"/Text2/Timer.start()
		my_label.text = "Я один из 7 могущественных артефактов"
		pc = 1.0/DlinTxt
	elif progress == 15:
		$"Автоматика сцены/CanvasGroup"/Name2.visible = false
		$"Автоматика сцены/CanvasGroup"/Грид.visible = false
		$"Автоматика сцены/CanvasGroup"/Син.visible = true
		$"Автоматика сцены/CanvasGroup"/Text2/Timer.start()
		my_label.text = "Неужели ты просто так валяешься на земле и без охраны"
		pc = 1.0/DlinTxt
	elif progress == 17:
		$"Автоматика сцены/CanvasGroup"/Name2.visible = true
		$"Автоматика сцены/CanvasGroup"/Грид.visible = true
		$"Автоматика сцены/CanvasGroup"/Син.visible = false
		$"Автоматика сцены/CanvasGroup"/Text2/Timer.start()
		my_label.text = "Вожак гоблинов не смог уталить мой голод и я поглотил его"
		pc = 1.0/DlinTxt
	elif progress == 19:
		$"Автоматика сцены/CanvasGroup"/Text2/Timer.start()
		my_label.text = "Остальные гоблины решили избавиться от меня и теперь я просто валяюсь на земле"
		pc = 1.0/DlinTxt	
	elif progress == 23:
		$"3Death".process_mode = Node.PROCESS_MODE_INHERIT
		$"3Death/Label".visible = false
		$"3Death/Label2".visible = false
		$"3Death/Label3".visible = false
		$GoblinTower.process_mode = Node.PROCESS_MODE_INHERIT
		Player.process_mode = Node.PROCESS_MODE_INHERIT
		camera.position = Player.position
		camera.player = Player
		camera.to_player = true
		var pos = $"3Death".position
		$"3Death/Goblin".position += pos
		$"3Death/Goblin2".position += pos
		$"3Death/Goblin3".position += pos
		$"3Death".position = Vector2.ZERO
