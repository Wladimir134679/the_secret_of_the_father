extends "res://objs/mobs/mob_obj.gd"

@onready var anim = $AnimatedSprite2D
@onready var timer_kd_run = $TimerKDRun
@onready var timer_stop_run = $TimerStopRun

func on_the_stand(delta):
	velocity = Vector2.ZERO
	anim.animation = 'idle'
	move_and_slide()
	if timer_kd_run.is_stopped():
		timer_kd_run.start(randf_range(0.5, 2))
	
func on_the_run(delta):
	anim.animation = 'jump'
	var pos = position
	move_and_slide()
	
	
func start_find_target():
	state_action = STATE_ACTION.RUN
	var pos = position
	var x = randi_range(-50, 50)
	var y = randi_range(-50, 50)
	velocity = Vector2(x, y).normalized() * speed
	timer_stop_run.start(randf_range(0.1, 2))
	
func _kd_run_path_dir():
	start_find_target()
