extends Node2D

class_name Gun


var dir
@export var sight : Node2D
@export var animationPlayer : Node2D
@export var bullet_scene : PackedScene
var can_shoot = true
var auto = false
var ammo = 10
var player_hand

func _physics_process(delta: float) -> void:
	if player_hand != null:
		global_position = player_hand.global_position
	var target_pos = get_global_mouse_position()
	dir = (target_pos - global_position).normalized()
	look_at(target_pos)
	if dir.x < 0:
		animationPlayer.scale.y = -0.25
	else:
		animationPlayer.scale.y = 0.25


func shoot():
	can_shoot = false
	spawn_bullet()
	animationPlayer.play("single_shoot")
	ammo -= 1
	if animationPlayer.is_playing():
		await animationPlayer.animation_finished
	can_shoot = true


func empty_shoot():
	can_shoot = false
	animationPlayer.play("empty_shoot")
	if animationPlayer.is_playing():
		await animationPlayer.animation_finished
	can_shoot = true
	

func spawn_bullet():
	var bullet = bullet_scene.instantiate()
	bullet.global_position = sight.global_position
	bullet.look_at(get_global_mouse_position())
	get_tree().root.add_child(bullet)
