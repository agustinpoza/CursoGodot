extends Node

@onready var this_wave = 0
var playerHealth
var playerPosition : Vector2

signal player_damaged
signal new_wave_reached
signal new_player_position

func reset_data():
	this_wave = 0
	playerHealth = 0

func update_player_pos(position):
	playerPosition = position
	emit_signal("new_player_position")


func update_player_health(health):
	playerHealth = health
	emit_signal("player_damaged")

func new_wave(wave):
	this_wave = wave
	emit_signal("new_wave_reached")
	
