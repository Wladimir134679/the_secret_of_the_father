extends Node2D

signal castle_crash
signal goblin_tower_crash
signal all_goblin_tower_crash

var current_level_scene_load: String

var next_level_scene: String

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	_castle_crash_update_all()
	_goblin_tower_update_all()

func _goblin_tower_update_all():
	var castles = get_tree().get_nodes_in_group("goblin_tower")
	var not_crash: bool = false
	for build in castles:
		if castle_crash_update(build):
			goblin_tower_crash.emit()
		if build.state_build != build.STATE_BUILD.CRASH:
			not_crash = true
	if !not_crash:
		all_goblin_tower_crash.emit()

func _castle_crash_update_all():
	var castles = get_tree().get_nodes_in_group("castle")
	for castle in castles:
		if castle_crash_update(castle):
			castle_crash.emit()

func castle_crash_update(main_castle) -> bool:
	if not main_castle:
		return false
	if 'health' in main_castle:
		if main_castle.health <= 0: 
			print("Здание умер")
			return true
	return false
