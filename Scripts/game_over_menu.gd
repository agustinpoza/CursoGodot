extends Control

func _ready() -> void:
	$Panel/Oleadas.text = "Superaste "+str(Global.this_wave)+" oleadas"

func _on_reintentar_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/World.tscn")
	Global.reset_data()
