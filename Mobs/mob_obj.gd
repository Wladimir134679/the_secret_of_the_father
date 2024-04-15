extends CharacterBody2D

enum STATE_ACTION {RUN, TARGET, DEAD, STAND, ATACK}

signal on_death

@export var state_action = STATE_ACTION.STAND
@export var auto_dead_queue = true

@onready var health = $HealthBar

func damage(da: int) -> void:
	health.minus(da)
	if health.current <= 0:
		death()

func death() -> void:
	if auto_dead_queue:
		queue_free()
	on_death.emit()
