extends "res://objs/building/building.gd"

var player = "res://player/player.gd"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('ui_action'):
		player.gold = 0 

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		pass
