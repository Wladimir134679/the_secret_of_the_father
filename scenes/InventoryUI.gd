extends HBoxContainer

var scene_item_ui = preload("res://scenes/ui/item.tscn")


func _process(delta: float) -> void:
	for id in Pack.inventory.keys():
		_process_item(id, Pack.inventory[id])

func _process_item(id, item):
	var find: bool = false
	for child in get_children():
		if child.item:
			if child.item.id == id:
				find = true
	if !find:
		var instance = scene_item_ui.instantiate()
		instance.item = item
		add_child(instance)
