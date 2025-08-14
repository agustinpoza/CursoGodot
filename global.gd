extends Node

@onready var oleada = 0
@export var playerLife = 10
signal player_damaged

func reset_data():
	oleada = 0
	playerLife = 0

func update_player_life(cant):
	playerLife -= cant
	emit_signal("player_damaged")
