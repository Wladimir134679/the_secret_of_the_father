extends ParallaxBackground

var speed = 70

func _process(delta):
	scroll_offset.x -= speed * delta
