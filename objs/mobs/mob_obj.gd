extends CharacterBody2D

enum STATE_ACTION {RUN, TARGET, DEAD, STAND, ATACK, INVULNERABILITY, PATROLLING}

signal on_death
signal on_damage

@export var state_action = STATE_ACTION.STAND
@export var auto_dead_queue = true
@export var speed = 130

@onready var health = $HealthBar
@onready var debug_info = $DebugInfo

func _process(delta):
	debug_info.text = "HP: " + str(health.current) + "\nState: " + STATE_ACTION.keys()[state_action] + "\nLen: " + str(velocity.length())
	
	match state_action:
		STATE_ACTION.RUN:
			on_the_run(delta)
		STATE_ACTION.INVULNERABILITY:
			on_the_invulnerability(delta)
		STATE_ACTION.TARGET:
			on_the_target(delta)
		STATE_ACTION.PATROLLING:
			on_the_patrolling(delta)
		STATE_ACTION.ATACK:
			on_the_atack(delta)
		STATE_ACTION.STAND:
			on_the_stand(delta)
		STATE_ACTION.DEAD:
			on_the_dead(delta)
			
		
func on_the_run(delta):
	pass

func on_the_target(delta):
	pass
	
func on_the_dead(delta):
	pass

func on_the_stand(delta):
	pass
	
func on_the_atack(delta):
	pass
	
func on_the_invulnerability(delta):
	pass
	
func on_the_patrolling(delta):
	pass
	
func on_the_damage(count: int, who = null):
	pass

func damage(da: int, who = null) -> void:
	if state_action == STATE_ACTION.INVULNERABILITY:
		return
	state_action = STATE_ACTION.INVULNERABILITY
	health.minus(da)
	on_damage.emit(who)
	on_the_damage(da, who)
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
