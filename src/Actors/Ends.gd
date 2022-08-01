extends "res://src/Actors/Actor.gd"

export var score:= 10000

var HEALTH: = 20
onready var sprite = $EndsAni

var skale = 0.2
func _ready() -> void:
	set_physics_process(false)
	velocity.x = -speed.x * 0.75
	

func _on_HeadshotDetector_body_entered(body: PhysicsBody2D) -> void:
	
	if body.global_position.y > get_node("HeadshotDetector").global_position.y:
		return 
	else:
		if HEALTH > 1:
			AudioManager.play("res://assets/Killsound.wav")
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
	AudioManager.play("res://assets/Among Us death 3.mp3")
	queue_free()
	PlayerData.score += score
