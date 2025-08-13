extends Area2D

@export var velocity = 500
@export var max_distance = 1000
@onready var spawn_distance = 0

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * velocity * delta
	spawn_distance += velocity * delta
	
	if spawn_distance >= max_distance:
		queue_free()
	
