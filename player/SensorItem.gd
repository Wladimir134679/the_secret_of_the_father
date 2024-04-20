extends Area2D

var item = null

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('ui_action'):
		if item:
			item.call('pick')
			item = null


func _on_area_entered(area: Area2D) -> void:
	var i = area.get_parent()
	if i.has_method('pick'):
		item = i



func _on_area_exited(area: Area2D) -> void:
	var i = area.get_parent()
	if i.has_method('pick'):
		item = null
