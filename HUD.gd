extends CanvasLayer

func _ready() -> void:
	Global.player_damaged.connect(update_health_label)
	Global.new_wave_reached.connect(update_wave_label)

func update_health_label():
	$Panel/LifeLabel.text = "Life: "+ str(Global.playerHealth)

func update_wave_label():
	$Panel/WaveLabel.text = "Oleada: "+ str(Global.this_wave)
