extends Node

@onready var player : CharacterBody2D = $Player
@onready var cant_enemigos = 5

func _ready() -> void:
	spawn_enemies()

func invocar_enemigo(position : Vector2):
	const ENEMY = preload("res://Scenes/Enemy.tscn")
	var instancia_enemigo = ENEMY.instantiate()
	instancia_enemigo.global_position = position
	instancia_enemigo.target = player
	instancia_enemigo.add_to_group("enemy")
	instancia_enemigo.enemigo_muerto.connect(check_fin_oleada)
	$Enemies.add_child(instancia_enemigo)

func spawn_enemies():
	for i in range(0,cant_enemigos):
		var points = $SpawnPoints.get_children()
		var random_point = points.pick_random()
		invocar_enemigo(random_point.global_position)
		await get_tree().create_timer(0.5).timeout
	Global.oleada += 1


func check_fin_oleada():
	await get_tree().process_frame
	if $Enemies.get_children().is_empty():
		spawn_enemies()


func _on_player_game_over() -> void:
	get_tree().change_scene_to_file("res://Scenes/game_over_menu.tscn")
