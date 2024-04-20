extends Node

signal adding_souls
signal new_experince_level

var speed_move = 200
var damage: int
var health: int
var health_max: int
var gold: int = 0
var souls: int = 0
var experience_level: int = 0
var experience_levels_count: Array[int] = [5, 7, 9, 13, 15, 18, 21, 26, 30, 40, 50, 65, 70, 90, 100]

func _ready() -> void:
	damage = 1
	health = 10
	health_max = health
	
func add_souls(val: int):
	souls += val
	adding_souls.emit()
	_calculate_level()

func _calculate_level():
	if experience_level >= experience_levels_count.size():
		return
	var sourls_new = experience_levels_count[experience_level + 1]
	if souls >= sourls_new:
		souls -= sourls_new
		experience_level += 1
		new_experince_level.emit()
		
