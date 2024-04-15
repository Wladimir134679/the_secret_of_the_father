extends AnimatedSprite2D

func _process(delta):
	var de = (GP.health / float(GP.health_max))
	frame = de * 1.0 * sprite_frames.get_frame_count('Health')
