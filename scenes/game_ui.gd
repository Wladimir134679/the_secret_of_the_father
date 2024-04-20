extends CanvasLayer

func _process(delta):
	$HeroBar/VBoxContainer/Gold2.text = str(GP.gold)
	$HeroBar/VBoxContainer/SoulsInfo.text = str(GP.souls)
	$HeroBar/VBoxContainer/LevelInfo.text = str(GP.experience_level) + " exp. lv."
