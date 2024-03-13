extends CharacterBody2D


const SPEED = 4500.0

var player
@onready var nav: NavigationAgent2D = $NavigationAgent2D

func _ready():
	player = get_tree().root.find_child('Player', true, false)


func _physics_process(delta: float) -> void:
	var dir = to_local(nav.get_next_path_position()).normalized()
	velocity = SPEED * delta * dir
	move_and_slide()


func _on_timer_2_timeout() -> void:
	nav.target_position = player.global_position
	

