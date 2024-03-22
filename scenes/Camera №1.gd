extends Camera2D

var pc = 0.02
@onready var progress = 0
@onready var my_label = $CanvasGroup/Text2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if progress == 0:
		if position.x != $"../Player".position.x:
			position.x += (($"../Player".position.x - position.x)/50)
		if position.y != $"../Player".position.y:
			position.y += (($"../Player".position.y - position.y)/50)
	elif progress == 2:
		$CanvasGroup/Text2.visible_ratio = 1.0
		my_label.text = "Какой замечательный день, это путешествие определенно того стоило!!!"
	elif progress == 4:
		$CanvasGroup/Text2.visible_ratio = 1.0
		my_label.text = "Эти троя даже не знают чего себя лишили, вот как найду могущественные артифакты ух"

func _on_timer_timeout():
	if $CanvasGroup/Text2.visible_ratio == 1.0:
		progress += 1
		$CanvasGroup/Text2/Timer.stop()
	else:
		$CanvasGroup/Text2.visible_ratio += pc

func _on_button_pressed():
	progress += 1
	if progress == 1:
		$CanvasGroup/Text2/Timer.start()
		$CanvasGroup.visible = true
		$CanvasGroup/Text2.visible_ratio = 0.0
		my_label.text = "Какой замечательный день, это путешествие определенно того стоило!!!"
	elif progress == 3:
		$CanvasGroup/Text2/Timer.start()
		$CanvasGroup/Text2.visible_ratio = 0.0
		my_label.text = "Эти троя даже не знают чего себя лишили, вот как найду могущественные артифакты и покажу им свои истиную силу"
	elif progress == 5:
		$"../Player".process_mode = Node.PROCESS_MODE_INHERIT
		$"../Player/HeroBar".visible = true
		visible = false
		enabled = false
