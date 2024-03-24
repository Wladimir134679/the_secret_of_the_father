extends Node2D

@export var max: int = 10
@export var current: int = 10

@onready var sprite: AnimatedSprite2D = $SpriteShow

func minus(value: int) -> void:
	current -= value
	update_sprite()
	
func update_new_value(max_new, current_new):
	max = max_new
	current = current_new
	update_sprite()

func _process(delta: float) -> void:
	update_sprite()

func update_sprite() -> void:
	var size = sprite.sprite_frames.get_frame_count('Health')
	sprite.frame = size * float(current / float(max))