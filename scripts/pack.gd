extends Node

var inventory = {}

func has(item_id) -> bool:
	return inventory.has(item_id)

func add(item):
	if has(item.id):
		inventory[item.id].count += item.count
	else:
		inventory[item.id] = {
			'id': item.id,
			'title': item.title,
			'description': item.description,
			'count': item.count,
			'texture': item.texture
		}
