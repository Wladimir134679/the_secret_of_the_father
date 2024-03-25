extends Node2D

signal crash_build

@export var completed = false
@export var comG = 0 
var health
@export var max_health = 10

@onready var health_bar: ProgressBar = $ProgressBar

func _ready() -> void:
	health = max_health
	update_health_bar()

func _process(delta: float) -> void:
	pass

func damage(damage: int):
	health -= damage
	print(damage)
	print(health)
	update_health_bar()
	if health <= 0:
		crash_build.emit()

func update_health_bar():
	health_bar.value = (health / float(max_health)) * 100
