class_name Purp
extends Actor

export var headshot_impulse: = 1000.0 

onready var sound: AudioStreamPlayer2D = get_node("AudioStreamPlayer2D")
onready var sound2: AudioStreamPlayer2D = get_node("AudioStreamPlayer2D2")

var HEALTH = 10

onready var sprite = $SpiderPurpAni

func _on_EnemyDetector_area_entered(area: Area2D) -> void:
	
	velocity = calculate_headshot_velocity(velocity, headshot_impulse)
	
func _on_EnemyDetector_body_entered(body: PhysicsBody2D) -> void:
	if HEALTH > 1:
		sound.play()
		HEALTH -= 1
	else:
		sound2.play()
		die()
	
	
func _physics_process(delta: float) -> void:
	var is_jump_interrupted: = Input.is_action_just_released("jump") and velocity.y < 0.0
	var direction: = get_direction()
	
	if direction.x != 0:
		if direction.x > 0:
			sprite.scale.x = -0.119
		else:
			sprite.scale.x = 0.119

	velocity = calculate_move_velocity(velocity, direction, speed, is_jump_interrupted)
	velocity = move_and_slide(velocity, FLOOR_NORMAL)
	
	
func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), 
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 0.0
	)

func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	var out: = linear_velocity
	out.x = speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time()			
	if direction.y == -1.0:
		out.y = speed.y * direction.y
	if is_jump_interrupted:
		out.y = 0.0
	return out

func calculate_headshot_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	var out: = linear_velocity
	out.y = -impulse
	return out

func die() -> void:
	PlayerData.deaths += 1
	queue_free()
	





