extends CenterContainer


func _ready() -> void:
	_close_level()
	GP.new_experince_level.connect(_open_level)

	
func _open_level():
	get_tree().paused = true
	self.show()
	
func _close_level():
	get_tree().paused = false
	self.hide()

func _click_health():
	GP.health += 1
	GP.health_max += 1
	_close_level()
	
func _click_atack():
	GP.damage += 1
	_close_level()
	
func _click_speed():
	GP.speed_move += 5
	_close_level()
