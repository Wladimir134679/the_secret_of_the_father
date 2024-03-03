extends Node2D




func _on_interact_obj_press_e() -> void:
	get_tree().change_scene_to_file("res://scenes/cellar.tscn")
