extends Node

signal adding_souls
signal new_experince_level

var speed_move = 150
var damage: int
var health: int
var health_max: int
var gold: int = 0
var souls: int = 0
var attack_speed: int
var attack_zone: int
var experience_level: int = 0
var experience_levels_count: Array[int] = [0, 3, 5, 7, 9, 13, 15, 18, 21, 26, 30, 40, 50, 65, 70, 90, 100]

func _ready() -> void:
	damage = 1
	health = 10
	health_max = health
	
func dead_to_respawn():
	health = health_max
	
func add_souls(val: int):
	souls += val
	adding_souls.emit()
	_calculate_level()
	
func next_count_level():
	if experience_level >= experience_levels_count.size():
		return "max"
	return experience_levels_count[experience_level + 1]

func _calculate_level():
	if experience_level >= experience_levels_count.size():
		return
	var sourls_new = experience_levels_count[experience_level + 1]
	if souls >= sourls_new:
		souls -= sourls_new
		experience_level += 1
		new_experince_level.emit()
		
