extends CanvasLayer

@onready var end_game_creen = $EndGame
@onready var win_screem = $Win

func _ready() -> void:
	end_game_creen.hide()
	win_screem.hide()
	ManagerLevel.castle_crash.connect(_open_end_game)
	ManagerLevel.all_goblin_tower_crash.connect(_win_game)

func _process(delta):
	$HeroBar/VBoxContainer/Gold2.text = str(GP.gold)
	$HeroBar/VBoxContainer/SoulsInfo.text = str(GP.souls) + "/" + str(GP.next_count_level())
	$HeroBar/VBoxContainer/LevelInfo.text = str(GP.experience_level) + " lv."
	
	if Input.is_action_pressed("open_pause"):
		_open_pause_menu()

func _open_end_game():
	end_game_creen.show()
	get_tree().paused = true
	
func _win_game() -> void:
	win_screem.show()
	get_tree().paused = true
	
func _open_pause_menu():
	$MenuPause.show()
	get_tree().paused = true


func _on_new_game_end_game_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_next_lvl_pressed() -> void:
	if ManagerLevel.next_level_scene:
		get_tree().change_scene_to_file(ManagerLevel.next_level_scene)


func _on_menu_pressed() -> void:
	await get_tree().change_scene_to_file("res://scenes/Menu.tscn")


func _on_continue_pressed() -> void:
	$MenuPause.hide()
	get_tree().paused = false


func _on_in_main_menu_pressed() -> void:
	$MenuPause.hide()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/Menu.tscn")
