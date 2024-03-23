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
		$"../Player/AnimatedSprite2D".process_mode = Node.PROCESS_MODE_ALWAYS
		if position.x != $"../Player".position.x:
			position.x += (($"../Player".position.x - position.x)/50)
		if position.y != $"../Player".position.y:
			position.y += (($"../Player".position.y - position.y)/50)
	elif progress == 2:
		$CanvasGroup/Text2.visible_ratio = 1.0
	elif progress == 4:
		$CanvasGroup/Text2.visible_ratio = 1.0
	elif progress == 5:
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
		if position.y >= 1760:
			$Button.process_mode = Node.PROCESS_MODE_INHERIT
			$"../Player".anim.play("Idle")
			$CanvasGroup/Text2.visible_ratio = 0.0
			$CanvasGroup/Text2/Timer.start()
			my_label.text = "Что за странный кулон?"
			pc = 1.0/my_label.text.length()
			$CanvasGroup.visible = true
			progress += 1
	elif progress == 8:
		$CanvasGroup/Text2.visible_ratio = 1.0
		
func _on_timer_timeout():
	if $CanvasGroup/Text2.visible_ratio == 1.0:
		if progress % 2 == 1:
			progress += 1
		elif progress == 6:
			progress += 2
		$CanvasGroup/Text2/Timer.stop()
	else:
		$CanvasGroup/Text2.visible_ratio += pc

func _on_button_pressed():
	progress += 1
	if progress == 1:
		position.x = $"../Player".position.x
		position.y = $"../Player".position.y
		$CanvasGroup/Text2.visible_ratio = 0.0
		$CanvasGroup/Text2/Timer.start()
		$CanvasGroup.visible = true
		my_label.text = "Какой замечательный день, это путешествие определенно того стоило!!!"
		pc = 1.0/my_label.text.length()
	elif progress == 3:
		$CanvasGroup/Text2.visible_ratio = 0.0
		$CanvasGroup/Text2/Timer.start()
		my_label.text = "Эти троя даже не знают чего себя лишили, вот как найду могущественные артифакты и покажу им свои истиную силу"
		pc = 1.0/my_label.text.length()
	elif progress == 9:
		$"../Player".process_mode = Node.PROCESS_MODE_INHERIT
		$"../Player/HeroBar".visible = true
		enabled = false
		visible = false
