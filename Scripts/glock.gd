extends Node2D

@onready var sight = $Glock/AnimatedSprite2D/Sight
var dir
@onready var timer = $Timer
var can_shoot = true

func _physics_process(delta: float) -> void:
	var target_pos = get_global_mouse_position()
	dir = (target_pos - global_position).normalized()
	look_at(target_pos)

func start_cooldown():
	timer.start()
	can_shoot = false
	


func _on_timer_timeout() -> void:
	can_shoot = true
