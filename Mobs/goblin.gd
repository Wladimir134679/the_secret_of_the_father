extends CharacterBody2D

var agr = false
var SPEED = 150.0

func _on_detector_body_entered(body):
	if body.name == "Player":
		agr = true

func _physics_process(delta: float) -> void:
	var player = $"../Player"
	var direction = (player.position - self.position).normalized()
	if agr == true:
		velocity.x = direction.x * SPEED
		velocity.y = direction.y * SPEED
	move_and_slide()
	
