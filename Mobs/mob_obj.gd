extends CharacterBody2D

signal on_death

@onready var health = $HealthBar

func damage(da: int) -> void:
	health.minus(da)
	if health.current <= 0:
		death()

func death() -> void:
	queue_free()
	on_death.emit()
