extends Control

onready var label: Label = get_node("Label2")
onready var sound2: AudioStreamPlayer2D = get_node("AudioStreamPlayer2D2")

func _ready() -> void:
	
	label.text = label.text % [PlayerData.score, PlayerData.deaths]
