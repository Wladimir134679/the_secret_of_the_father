extends Node2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	if anim.frame >= anim.sprite_frames.get_frame_count('default') - 1:
		queue_free()
