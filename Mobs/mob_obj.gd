extends CharacterBody2D

enum STATE_ACTION {RUN, TARGET, DEAD, STAND, ATACK, INVULNERABILITY, PATROLLING}

signal on_death
signal on_damage

@export var state_action = STATE_ACTION.STAND
@export var auto_dead_queue = true

@onready var health = $HealthBar

func damage(da: int, who = null) -> void:
	if state_action == STATE_ACTION.INVULNERABILITY:
		return
	state_action = STATE_ACTION.INVULNERABILITY
	health.minus(da)
	on_damage.emit(who)
	$InvulnerabilityTimer.start()
	if health.current <= 0:
		death()

func death() -> void:
	state_action = STATE_ACTION.DEAD
	on_death.emit()
	if auto_dead_queue:
		queue_free()


func _on_invulnerability_timer_timeout() -> void:
	state_action = STATE_ACTION.STAND
