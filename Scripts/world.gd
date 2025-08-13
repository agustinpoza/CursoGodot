extends Node

@onready var player : CharacterBody2D = $Player
@onready var cant_enemigos = 5

func _ready() -> void:
	for i in range(0,cant_enemigos):
		var points = $SpawnPoints.get_children()
		var random_point = points.pick_random()
		#invocar_enemigo(random_point.global_position)
		await get_tree().create_timer(0.5).timeout


func invocar_enemigo(position : Vector2):
	const ENEMY = preload("res://Scenes/Enemy.tscn")
	var instancia_enemigo = ENEMY.instantiate()
	instancia_enemigo.global_position = position
	instancia_enemigo.target = player
	add_child(instancia_enemigo)
