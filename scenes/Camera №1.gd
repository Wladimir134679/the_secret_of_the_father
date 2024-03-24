extends Camera2D

var pc = 0
@onready var progress = 0
@onready var my_label = $CanvasGroup/Text2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if progress == 0:
		$"../3Death".process_mode = Node.PROCESS_MODE_DISABLED
		$"../Player/AnimatedSprite2D".process_mode = Node.PROCESS_MODE_ALWAYS
		if position.x != $"../Player".position.x:
			position.x += (($"../Player".position.x - position.x)/50)
		if position.y != $"../Player".position.y:
			position.y += (($"../Player".position.y - position.y)/50)
	elif progress == 2:
		$CanvasGroup/Text2.visible_ratio = 1.0
	elif progress == 4:
		$CanvasGroup/Text2.visible_ratio = 1.0
	elif progress == 6:
		$CanvasGroup/Text2.visible_ratio = 1.0
	elif progress == 7:
		$Button.process_mode = Node.PROCESS_MODE_DISABLED
		$CanvasGroup.visible = false
		if position.x != $"../Player".position.x:
			position.x += (($"../Player".position.x - position.x)/50)
		if position.y != $"../Player".position.y:
			position.y += (($"../Player".position.y - position.y)/50)
		if $"../Player".position.x != 1400:
			$"../Player".position.x += 2
		if $"../Player".position.y != 1800:
			$"../Player".position.y += 1
		$"../Player".anim.play("Walk")
		if position.y >= 1740:
			$"../Grid".visible = false
			$Button.process_mode = Node.PROCESS_MODE_INHERIT
			$"../Player".anim.play("Idle")
			$CanvasGroup/Text2.visible_ratio = 0.0
			$CanvasGroup/Text2/Timer.start()
			my_label.text = "Что за странный кулон?"
			pc = 1.0/my_label.text.length()
			$CanvasGroup.visible = true
			progress += 1
	elif progress == 10:
		$CanvasGroup/Text2.visible_ratio = 1.0
	elif progress == 12:
		$CanvasGroup/Text2.visible_ratio = 1.0
	elif progress == 14:
		$CanvasGroup/Text2.visible_ratio = 1.0
	elif progress == 16:
		$CanvasGroup/Text2.visible_ratio = 1.0
	elif progress == 18:
		$CanvasGroup/Text2.visible_ratio = 1.0
	elif progress == 20:
		$CanvasGroup/Text2.visible_ratio = 1.0
	elif progress == 21:
		$Button.process_mode = Node.PROCESS_MODE_DISABLED
		$CanvasGroup.visible = false
		$"../3Death/Goblin".anim.play("Walk")
		$"../3Death/Goblin2".anim.play("Walk")
		$"../3Death/Goblin3".anim.play("Walk")
		if $"../3Death".position.x != 1000:
			$"../3Death".position.x += ((1000 - $"../3Death".position.x)/150)
		if $"../3Death".position.y != 1800:
			$"../3Death".position.y += ((1750 - $"../3Death".position.y)/150)
		if $"../3Death".position.x <= 1010:
			$"../3Death/Goblin".anim.play("Idle")
			$"../3Death/Goblin2".anim.play("Idle")
			$"../3Death/Goblin3".anim.play("Idle")
			$Button.process_mode = Node.PROCESS_MODE_INHERIT
			progress += 1
	elif progress == 22:
		$"../3Death/Label".visible = true
		$"../3Death/Label2".visible = true
		$"../3Death/Label3".visible = true
		
func _on_timer_timeout():
	if $CanvasGroup/Text2.visible_ratio == 1.0:
		if progress % 2 == 1:
			progress += 1
		elif progress == 8:
			progress += 2
		$CanvasGroup/Text2/Timer.stop()
	else:
		$CanvasGroup/Text2.visible_ratio += pc

func _on_button_pressed():
	progress += 1
	$CanvasGroup/Text2.visible_ratio = 0.0
	if progress == 1:
		position.x = $"../Player".position.x
		position.y = $"../Player".position.y
		$CanvasGroup/Text2/Timer.start()
		$CanvasGroup.visible = true
		my_label.text = "Какой замечательный день, это путешествие определенно того стоило!"
		pc = 1.0/my_label.text.length()
	elif progress == 3:
		$CanvasGroup/Text2/Timer.start()
		my_label.text = "Они даже не знают чего лишили себя"
		pc = 1.0/my_label.text.length()
	elif progress == 5:
		$CanvasGroup/Text2/Timer.start()
		my_label.text = "Откуда этот странный голос?"
		pc = 1.0/my_label.text.length()
	elif progress == 11:
		$CanvasGroup/Grid.visible = true
		$CanvasGroup/Name2.visible = true
		$CanvasGroup/Text2/Timer.start()
		my_label.text = "Что ты такое?"
		pc = 1.0/my_label.text.length()
	elif progress == 13:
		$CanvasGroup/Name2/Name2.visible = true
		$CanvasGroup/Name/Name.visible = false
		$CanvasGroup/Text2/Timer.start()
		my_label.text = "Я один из 7 могущественных артефактов"
		pc = 1.0/my_label.text.length()
	elif progress == 15:
		$CanvasGroup/Name2/Name2.visible = false
		$CanvasGroup/Name/Name.visible = true
		$CanvasGroup/Text2/Timer.start()
		my_label.text = "Неужели ты просто так валяешься на земле и без охраны"
		pc = 1.0/my_label.text.length()
	elif progress == 17:
		$CanvasGroup/Name2/Name2.visible = true
		$CanvasGroup/Name/Name.visible = false
		$CanvasGroup/Text2/Timer.start()
		my_label.text = "Вожак гоблинов не смог уталить мой голод и я поглотил его"
		pc = 1.0/my_label.text.length()
	elif progress == 19:
		$CanvasGroup/Text2/Timer.start()
		my_label.text = "Остальные гоблины решили избавиться от меня и теперь я просто валяюсь на земле"
		pc = 1.0/my_label.text.length()	
	elif progress == 23:
		$"../3Death".process_mode = Node.PROCESS_MODE_INHERIT
		$"../3Death/Label".visible = false
		$"../3Death/Label2".visible = false
		$"../3Death/Label3".visible = false
		$"../Player".process_mode = Node.PROCESS_MODE_INHERIT
		$"../Player/HeroBar".visible = true
		enabled = false
		visible = false
