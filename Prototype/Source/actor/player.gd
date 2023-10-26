extends actor

#here jumping is different on Godot 4
@export var jump_impulse=-1400.0
@export var stomp_impulse=1000.0
@export var wall_slide_acceleration =10.0
@export var max_wall_slide_speed= 120.0
var can_jump = false

func _on_enemydetector_area_entered(area):
	velocity=calculate_stomp_velocity(velocity, stomp_impulse)
	
func _on_enemydetector_body_entered(body):
	die()

func _physics_process(delta):
	var is_jump_interrupted = Input.is_action_just_released("jump") and velocity.y<0.0
	var direction = get_direction()
	velocity=calculate_move_velocity(velocity, speed, direction, is_jump_interrupted)
	if is_on_wall() && (Input.is_action_pressed("move_left")|| Input.is_action_pressed("move_right")):
		wallcling()
	elif is_on_floor():
		can_jump=true
	else:
		can_jump=false
	move_and_slide()

func get_direction()->Vector2:
	return Vector2(
		Input.get_action_strength("move_right")-Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	)

func calculate_move_velocity(
	linear_velocity:Vector2,
	speed: Vector2,
	direction: Vector2,
	is_jump_interrupted: bool
)-> Vector2:
	var output = linear_velocity
	output.x=speed.x*direction.x
	output.y+=gravity*get_physics_process_delta_time()
	
	if can_jump and Input.is_action_just_pressed("jump"):
		output.y=jump_impulse
	if is_jump_interrupted:
		output.y=0.0
	return output

func calculate_stomp_velocity(linear_velocity: Vector2, impulse:float)->Vector2:
	var output=linear_velocity
	output.y=-impulse
	return output

func die():
	PlayerData.deaths+=1;
	queue_free()

func wallcling():
	can_jump=true
	if velocity.y>=0:
		velocity.y=min(velocity.y+wall_slide_acceleration, max_wall_slide_speed)



