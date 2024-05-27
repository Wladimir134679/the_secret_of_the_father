extends Node2D

@export var spawn_to_start: bool = false
@export var time_package: float = 0
@export var count_package: int = 0
var count_current_spawn: int = 0
# время через которое нужно заспавнить одного моба
@export var time: float = 1
# рандомность для случайности 0 - нет её
@export var time_rnd: float = 0
# какую сцену спавнить на это точке
@export var spawn_scene: PackedScene = null
# куда её добавить - нода с цены
@export var to_node : Node2D = null
# если дали куда класть новые элементы, то в него локально или глобально
@export var local_node: bool = false
# класть сверх родителя, то есть на родятеля родителя сцены
@export var up_parent: bool = false

# остановка спавнинга
@export var stop_spawn: bool = false

# в какой зоне спавнить, берёт shape, там в зоне радиус менять только
@onready var zone_spawn: CollisionShape2D = $ZoneSpawn/CollisionShape2D
@onready var timer: Timer = $Timer
@onready var timer_kd: Timer = $TimerKD

func _ready() -> void:
	self.start()
	if spawn_to_start:
		spart_obj()


func _process(delta: float) -> void:
	pass
	

func _on_timer_timeout() -> void:
	if !stop_spawn:
		self.spart_obj()
		self.start()
	

func spart_obj() -> void:
	if !to_node and !spawn_scene:
		return
	
	count_current_spawn += 1
	if time_package != 0:
		if count_current_spawn <= count_package:
			timer_kd.start(time_package)
	
	var inst = spawn_scene.instantiate()
	inst.position = get_rnd_spawn_position()
	var n_to
	if not to_node:
		n_to = get_parent()
	else:
		n_to = to_node
	if up_parent:
		n_to = n_to.get_parent()
	
	n_to.add_child(inst)

func get_rnd_spawn_position() -> Vector2:
	var zone_s = zone_spawn.shape.get_rect().position * scale
	var zone_e = zone_spawn.shape.get_rect().end * scale
	var origin_s = zone_s if local_node else global_position - zone_s
	var origin_e = zone_e if local_node else global_position - zone_e
	
	var x = randf_range(origin_s.x, origin_e.x)
	var y = randf_range(origin_s.y, origin_e.y)
	
	return Vector2(x, y)
	
func stop():
	stop_spawn = true

func start() -> void:
	var _time = time if time_rnd == 0 else time + time_rnd * randf()
	stop_spawn = false
	count_current_spawn = 0
	timer.start(_time)
