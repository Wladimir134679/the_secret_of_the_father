extends Area2D

@onready var build = $".."
@onready var info_build = $"../Node2D/ZoneBuildInfo"
@onready var info_price = $"../Node2D/PriceInfo"

var is_player_in_zone: bool = false

func _ready():
	_hide_activation()


func _process(delta):
	if is_player_in_zone && _is_state():
		if Input.is_action_pressed("action_e"):
			if GP.gold >= build.price_build:
				GP.gold -= build.price_build
				build.state_build = build.STATE_BUILD.WORK
				build.health = build.max_health
				build.emit_signal('build_zone')

func _on_body_entered(body):
	is_player_in_zone = true
	if _is_state():
		_show_activation()

func _on_body_exited(body):
	is_player_in_zone = false
	_hide_activation()
		
func _show_activation():
	info_build.show()
	info_price.show()
	if GP.gold >= build.price_build:
		info_build.label_settings.font_color = Color(0, 1, 0)
	else:
		info_build.label_settings.font_color = Color(1, 0, 0)
		
func _hide_activation():
	info_build.hide()
	info_price.hide()
	
func _is_state() -> bool:
	for st in build.state_activation:
		if st == build.state_build:
			return true
	return false


func _on_building_crash_build():
	if not is_player_in_zone:
		return
	if _is_state():
		_show_activation()
	else:
		_hide_activation()


func _on_building_build_zone():
	if not is_player_in_zone:
		return
	if _is_state():
		_show_activation()
	else:
		_hide_activation()
