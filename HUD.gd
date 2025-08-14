extends CanvasLayer

func _ready() -> void:
	updateLifeLabel()
	updateWaveLabel()
	Global.player_damaged.connect(updateLifeLabel)

func updateLifeLabel():
	$Panel/LifeLabel.text = "Life: "+ str(Global.playerLife)

func updateWaveLabel():
	$Panel/WaveLabel.text = "Oleada: "+ str(Global.oleada)
