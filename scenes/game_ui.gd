extends CanvasLayer

@onready var end_game_creen = $EndGame

func _ready() -> void:
	end_game_creen.hide()
	ManagerLevel.castle_crash.connect(_open_end_game)

func _process(delta):
	$HeroBar/VBoxContainer/Gold2.text = str(GP.gold)
	$HeroBar/VBoxContainer/SoulsInfo.text = str(GP.souls) + "/" + str(GP.next_count_level())
	$HeroBar/VBoxContainer/LevelInfo.text = str(GP.experience_level) + " lv."

func _open_end_game():
	end_game_creen.show()
	get_tree().paused = true


func _on_new_game_end_game_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
