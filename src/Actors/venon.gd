extends "res://src/Actors/Actor.gd"

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
			HEALTH -= 1
		else:
			get_node("CollisionShape2D").disabled = true
			queue_free()
	

	
func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta

	if is_on_wall():
		yield(sprite, "animation_finished")
		velocity.x *= -1.0
		skale*= -1.0
		sprite.scale.x = skale
		
	velocity.y = move_and_slide(velocity, FLOOR_NORMAL).y	

