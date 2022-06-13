extends "res://src/Actors/Actor.gd"

var HEALTH: = 5
onready var sprite = $Venon

func _ready() -> void:
	set_physics_process(false)
	velocity.x = -speed.x

func _on_HeadshotDetector_body_entered(body: PhysicsBody2D) -> void:
	if body.global_position.y > get_node("HeadshotDetector").global_position.y:
		return 
	if HEALTH > 1:
		HEALTH -= 1
	else:
		get_node("CollisionShape2D").disabled = true
		queue_free()
	

func get_direction() -> Vector2:
	return Vector2(0.0, 0.0)
	
func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	var direction = get_direction()
	if direction.x != 0:
		if direction.x > 0:
			sprite.scale.x = -0.119
		else:
			sprite.scale.x = 0.119

	if is_on_wall():
		velocity.x *= -1.0
	velocity.y = move_and_slide(velocity, FLOOR_NORMAL).y	



