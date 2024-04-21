extends Node2D

signal castle_crash

var current_level_scene_load: String

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	castle_crash_update_all()

func castle_crash_update_all():
	var castles = get_tree().get_nodes_in_group("castle")
	for castle in castles:
		castle_crash_update(castle)

func castle_crash_update(main_castle):
	if not main_castle:
		return
	if 'health' in main_castle:
		if main_castle.health <= 0: 
			print("Здание умер")
			castle_crash.emit()
