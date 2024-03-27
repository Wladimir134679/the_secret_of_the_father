extends Node

var damage: int
var health: int
var health_max: int
var gold: int = 0

func _ready() -> void:
	damage = 4
	health = 10
	health_max = health
