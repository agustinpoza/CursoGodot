extends Node

@onready var this_wave = 0
var playerHealth
var playerPosition : Vector2

var blood_particle = preload("res://Scenes/blood_particles.tscn")

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
	
func create_particle(vfx_name, pos):
	var selected_particle
	match vfx_name:
		"blood_particle":
			selected_particle = blood_particle
	var new_particle = selected_particle.instantiate()
	new_particle.position = pos
	new_particle.emitting = true
	get_tree().current_scene.add_child(new_particle)
	await get_tree().create_timer(3).timeout
	destroy_particle(new_particle)

func destroy_particle(particle):
	particle.queue_free()
