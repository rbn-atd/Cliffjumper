extends Area2D

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")
onready var sound: AudioStreamPlayer2D = get_node("AudioStreamPlayer2D")
export var score: = 200


func _on_body_entered(body: PhysicsBody2D) -> void:
	eaten()
	
func eaten() -> void:
	PlayerData.score += score
	anim_player.play("eaten")
	sound.play()
