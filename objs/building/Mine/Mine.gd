extends "res://objs/building/building.gd"

func _ready():
	pass # Replace with function body.


func _process(delta):
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('ui_action'):
		GP.gold = 0 

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		pass
