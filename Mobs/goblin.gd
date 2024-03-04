extends CharacterBody2D

var stands = true
var SPEED = 130
var destination = Vector2()
var vel = Vector2()
var prev_pos = Vector2()
var target = null

func _ready():
	SPEED = 100

func _process(delta):
	if vel:
		prev_pos = position
		move_and_slide()
		position.x = clamp(position.x, 0, 10000)
		position.y = clamp(position.y, 0, 10000)
	wander()
	search_for_target()
	
func search_for_target():
	var pl = $"../Player"
	if position.distance_to(pl.position) < 200:
		cancel_movement()
		target = pl
	else:
		if target:
			cancel_movement()
		target = null
	if target:
		set_destination(target.position)
	
func set_destination(dest):
	destination = dest
	vel = (destination - position).normalized() * SPEED
	stands = false
	
func cancel_movement():
	vel = Vector2()
	destination = Vector2()
	$StandingTimer.start(2)

func wander():
	var pos = position
	if stands:
		randomize()
		
		var x = int(randf_range(pos.x - 150, pos.x + 150))
		var y = int(randf_range(pos.y - 150, pos.y + 150))
		
		x = clamp(x, 0, 10000)
		y = clamp(y, 0, 10000)
		
		set_destination(Vector2(x, y))
	elif vel != Vector2():
		if pos.distance_to(destination) <= SPEED:
			cancel_movement()
		elif pos.distance_to(prev_pos) <= 0.6:
			cancel_movement()

func _on_timer_timeout():
	stands = true
