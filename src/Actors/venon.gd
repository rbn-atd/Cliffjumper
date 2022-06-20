extends "res://src/Actors/Actor.gd"

export var score:= 100

onready var sound: AudioStreamPlayer2D = get_node("AudioStreamPlayer2D")
onready var sound2: AudioStreamPlayer2D = get_node("AudioStreamPlayer2D2")

var HEALTH: = 2
onready var sprite = $VenonAni

var skale = 0.119
func _ready() -> void:
	set_physics_process(false)
	velocity.x = -speed.x
	

func _on_HeadshotDetector_body_entered(body: PhysicsBody2D) -> void:
	
	if body.global_position.y > get_node("HeadshotDetector").global_position.y:
		return 
	else:
		if HEALTH > 1:
			sound.play()
			HEALTH -= 1
		else:
			
			get_node("CollisionShape2D").disabled = true
			die()
		
	

	
func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta

	if is_on_wall():
		yield(sprite, "animation_finished")
		velocity.x *= -1.0
		skale*= -1.0
		sprite.scale.x = skale
		
	velocity.y = move_and_slide(velocity, FLOOR_NORMAL).y	

func die() -> void:
	sound2.play()
	queue_free()
	PlayerData.score += score
