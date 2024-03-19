extends AnimatedSprite2D


func _ready():
	pass
	
func _process(delta):
	if $"../..".health == 8:
		frame = 8
	elif $"../..".health == 7:
		frame = 7
	elif $"../..".health == 6:
		frame = 6
	elif $"../..".health == 5:
		frame = 5
	elif $"../..".health == 4:
		frame = 4
	elif $"../..".health == 3:
		frame = 3
	elif $"../..".health == 2:
		frame = 2
	elif $"../..".health == 1:
		frame = 1
	else:
		frame = 0
