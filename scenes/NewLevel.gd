extends CenterContainer

@onready var timer: Timer = $TimerTo
@onready var progress_bar: ProgressBar = $"../NewLevelPlayerInfo/VBoxContainer/ProgressBar"

func _ready() -> void:
	_close_level()
	GP.new_experince_level.connect(_open_level)
	progress_bar.max_value = timer.wait_time
	
func _process(delta: float) -> void:
	progress_bar.value = timer.wait_time - timer.time_left

	
func _open_level():
	get_tree().paused = true
	$"../NewLevelPlayerInfo".show()
	$"../NewLevelPlayerInfo/AudioStreamPlayer".play()
	timer.start()
	
func _close_level():
	get_tree().paused = false
	$"../MenuPause".hide()
	self.hide()

func _click_health():
	GP.health += 2
	GP.health_max += 2
	_close_level()
	
func _click_atack():
	GP.damage += 1
	_close_level()
	
func _click_speed():
	GP.speed_move += 25
	_close_level()


func _on_timer_to_timeout() -> void:
	$"../NewLevelPlayerInfo".hide()
	self.show()
