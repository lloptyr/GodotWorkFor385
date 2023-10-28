extends actor

#here jumping is different on Godot 4
@export var jump_impulse=-1400.0
@export var pogo_impulse=1000.0
@export var wall_slide_acceleration =10.0
@export var max_wall_slide_speed= 120.0
@onready var _animated_sprite = $AnimatedSprite2D
var can_jump = false
var is_dead = false
var is_falling = false

func _process(delta):
	if (!is_dead):
		if Input.is_action_just_pressed("attack") && Input.is_action_pressed("down"):
			_animated_sprite.play("attack down")
		elif Input.is_action_just_pressed("attack") && Input.is_action_pressed("down") && Input.is_action_pressed("jump"):
			_animated_sprite.play("attack down")
		elif Input.is_action_just_pressed("attack") && Input.is_action_pressed("jump"):
			_animated_sprite.play("attack forwards")
		elif Input.is_action_just_pressed("attack"):
			_animated_sprite.play("attack forwards")
		elif Input.is_action_pressed("jump") && is_falling && !(_animated_sprite.animation=="attack forwards" || _animated_sprite.animation=="attack down"):
			_animated_sprite.play("jump")
		elif (_animated_sprite.animation == "jump" && !is_falling):
			_animated_sprite.play("recover")
		elif is_falling && !(_animated_sprite.animation=="attack forwards" || _animated_sprite.animation=="attack down" || _animated_sprite.animation=="jump"):
			_animated_sprite.play("fall")
		elif (_animated_sprite.animation == "fall" && !is_falling):
			_animated_sprite.play("recover")
		elif (Input.is_action_pressed("move_right") || Input.is_action_pressed("move_left")) && !(_animated_sprite.animation=="attack forwards" || _animated_sprite.animation=="attack down"):
			_animated_sprite.play("running")
		elif(Input.is_action_just_released("move_left")||Input.is_action_just_released("move_right")):
				_animated_sprite.stop()
		elif !_animated_sprite.is_playing() && !is_falling:
			_animated_sprite.play("idle")
		
		if(_animated_sprite.animation=="attack forwards" && !_animated_sprite.flip_h):
			_animated_sprite.get_node("Hitboxfront/damagebox").disabled=false
			await(_animated_sprite.animation_finished)
			_animated_sprite.get_node("Hitboxfront/damagebox").disabled=true
		if(_animated_sprite.animation=="attack forwards" && _animated_sprite.flip_h):
			_animated_sprite.get_node("Hitboxback/damagebox").disabled=false
			await(_animated_sprite.animation_finished)
			_animated_sprite.get_node("Hitboxback/damagebox").disabled=true
		if _animated_sprite.animation=="attack down":
			_animated_sprite.get_node("Hitboxdown/downbox").disabled=false
			await(_animated_sprite.animation_finished)
			_animated_sprite.get_node("Hitboxdown/downbox").disabled=true



func _on_hitboxdown_area_entered(area):
	if get_node("AnimatedSprite2D/Hitboxdown/downbox").disabled==false:
		velocity=calculate_pogo_velocity(velocity, pogo_impulse)
	
func _on_enemydetector_body_entered(body):
	is_dead=true
	die()

func _physics_process(delta):
	if(!is_dead):
		is_falling=false
		var is_jump_interrupted = Input.is_action_just_released("jump") and velocity.y<0.0
		var direction = get_direction()
		if (velocity.x<0):
			_animated_sprite.flip_h=true
		if(velocity.x>0):
			_animated_sprite.flip_h=false
		velocity=calculate_move_velocity(velocity, speed, direction, is_jump_interrupted)
		if is_on_wall() && (Input.is_action_pressed("move_left")|| Input.is_action_pressed("move_right")):
			wallcling()
		elif is_on_floor():
			can_jump=true
		else:
			is_falling=true
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

func calculate_pogo_velocity(linear_velocity: Vector2, impulse:float)->Vector2:
	var output=linear_velocity
	output.y=-impulse
	return output

func die():
	velocity = Vector2(0,0)
	_animated_sprite.play("death")
	await( _animated_sprite.animation_finished)
	PlayerData.deaths+=1
	is_dead=false
	queue_free()

func wallcling():
	if PlayerData.get_wallcling():
		can_jump=true
		if velocity.y>=0:
			velocity.y=min(velocity.y+wall_slide_acceleration, max_wall_slide_speed)








