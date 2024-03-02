extends Node2D

signal press_e

@onready var label : Label = $ShowInfo
var is_collision = false

func _ready() -> void:
	label.hide()
	pass



func _input(event: InputEvent) -> void:
	if is_collision:
		if event.is_action_released("action_e"):
			press_e.emit()


func _on_sensor_body_entered(body: Node2D) -> void:
	is_collision = true
	label.show()


func _on_sensor_body_exited(body: Node2D) -> void:
	is_collision = false
	label.hide()
