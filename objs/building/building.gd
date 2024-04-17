extends Node2D

enum STATE_BUILD {
	CRASH,
	SOURCE,
	WORK
}

signal crash_build

@export var max_health: int = 10
var health: int
var state_build: STATE_BUILD

@onready var health_bar: ProgressBar = $ProgressBar

func _ready() -> void:
	health = max_health
	update_health_bar()
	state_build = STATE_BUILD.SOURCE

func _process(delta: float) -> void:
	pass

func damage(damage: int):
	health -= damage
	update_health_bar()
	if health <= 0:
		crash_build.emit()

func update_health_bar():
	health_bar.value = (health / float(max_health)) * 100
