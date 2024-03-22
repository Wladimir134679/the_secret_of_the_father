extends Camera2D

var pc = 0.015
var progress = 0
@onready var my_label = $Text2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if progress == 1:
		if position.x != $"../Player".position.x:
			position.x += (($"../Player".position.x - position.x)/50)
		if position.y != $"../Player".position.y:
			position.y += (($"../Player".position.y - position.y)/50)

func _on_timer_timeout():
	if $Text2.visible_ratio == 0.99:
		$Timer.stop()
	else:
		$Text2.visible_ratio += pc

func _on_button_pressed():
	progress += 1
	if progress == 1:
		$Dialog.visible = true
		$Text2.visible_ratio = 0.0
		my_label.text = "Какой замечательный день, это путешествие определенно того стоило!!!"
	elif progress == 2:
		$Text2.visible_ratio = 1.0
		my_label.text = "Какой замечательный день, это путешествие определенно того стоило!!!"
	elif progress == 3:
		$Text2.visible_ratio = 0.0
		my_label.text = "Эти троя даже не знают чего себя лишили, вот как найду могущественные артифакты ух"
	elif progress == 4:
		$Text2.visible_ratio = 1.0
		my_label.text = "Эти троя даже не знают чего себя лишили, вот как найду могущественные артифакты ух"
	elif progress == 5:
		$"../Player".process_mode = Node.PROCESS_MODE_INHERIT
		visible = false
		enabled = false
