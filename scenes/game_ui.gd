extends CanvasLayer

func _process(delta):
	$HeroBar/VBoxContainer/Gold2.text = str(GP.gold)
	$HeroBar/VBoxContainer/SoulsInfo.text = str(GP.souls) + "/" + str(GP.next_count_level())
	$HeroBar/VBoxContainer/LevelInfo.text = str(GP.experience_level) + " lv."
