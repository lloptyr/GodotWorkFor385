extends actor

#here jumping is different on Godot 4
@export var jump_impulse=-1200.0
@export var pogo_impulse=1000.0
@export var wall_slide_acceleration =10.0
@export var max_wall_slide_speed= 120.0
@onready var _animated_sprite = $AnimatedSprite2D
@onready var sword_swing =get_node("swordswingaudio")
@onready var jumpnoise=get_node("jumpnoise")
@onready var camera=get_node("Camera2D")
@onready var defaultcamera=Vector2(0,0)
var can_jump = false
var is_dead = false
var is_falling = false
var is_being_damaged=false
var damage_impulse=500
var i_frames=false
var attack_cd=false




func _process(delta):
	if(camera.get_offset()!=defaultcamera && !Input.is_action_pressed("down")):
		camera.set_offset(defaultcamera)
	if (!is_dead):
		if Input.is_action_just_pressed("attack") && Input.is_action_pressed("down") && !attack_cd:
			_animated_sprite.play("attack down")
		elif Input.is_action_just_pressed("attack") && Input.is_action_pressed("down") && Input.is_action_pressed("jump") && !attack_cd:
			_animated_sprite.play("attack down")
		elif Input.is_action_just_pressed("attack") && Input.is_action_pressed("jump") && !attack_cd:
			_animated_sprite.play("attack forwards")
		elif Input.is_action_just_pressed("attack") && !attack_cd:
			_animated_sprite.play("attack forwards")
		elif Input.is_action_pressed("jump") && is_falling && !(_animated_sprite.animation=="attack forwards" || _animated_sprite.animation=="attack down"):
			jumpnoise.playing=true
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
		elif(Input.is_action_just_pressed("down")):
			await(get_tree().create_timer(1).timeout)
			camera.set_offset(Vector2(0,250))
		elif !_animated_sprite.is_playing() && !is_falling:
			_animated_sprite.play("idle")
		
		if(_animated_sprite.animation=="attack forwards" && !_animated_sprite.flip_h):
			_animated_sprite.get_node("Hitboxfront/damagebox").disabled=false
			attack_cd=true
			sword_swing.playing=true
			await(sword_swing.finished)
			attack_cd=false
			_animated_sprite.get_node("Hitboxfront/damagebox").disabled=true
		if(_animated_sprite.animation=="attack forwards" && _animated_sprite.flip_h):
			_animated_sprite.get_node("Hitboxback/damagebox").disabled=false
			attack_cd=true
			sword_swing.playing=true
			await(sword_swing.finished)
			attack_cd=false
			_animated_sprite.get_node("Hitboxback/damagebox").disabled=true
		if _animated_sprite.animation=="attack down":
			_animated_sprite.get_node("Hitboxdown/downbox").disabled=false
			attack_cd=true
			sword_swing.playing=true
			await(sword_swing.finished)
			attack_cd=false
			_animated_sprite.get_node("Hitboxdown/downbox").disabled=true
			
		if PlayerData.get_allow_save() && Input.is_action_just_pressed("interact"):
			PlayerData.set_HP(PlayerData.get_max_HP())
			get_node("healednoise").playing=true
			PlayerData.save_game_state()




func _on_hitboxdown_area_entered(area):
	if get_node("AnimatedSprite2D/Hitboxdown/downbox").disabled==false:
		velocity=calculate_pogo_velocity(velocity, pogo_impulse)
		
func damage_boost():
	velocity=calculate_damage_boost(velocity, damage_impulse)
	
func _on_enemydetector_body_entered(body):
	if(i_frames==false):
		is_being_damaged=true;
		PlayerData.take_damage(1)
		i_frames_counter()
		damage_boost()
		get_node("takedamagenoise").playing=true
		await(get_tree().create_timer(0.2).timeout)
		is_being_damaged=false
		if(PlayerData.get_HP()<=0):
			is_dead=true
			die()

# NEEDS TESTING AND DEBUGGING
func i_frames_counter():
	i_frames=true
	await(get_tree().create_timer(.5).timeout)
	i_frames=false

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
	if(!is_being_damaged):
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

func calculate_damage_boost(linear_velocity: Vector2, impulse: float)->Vector2:
	var output=linear_velocity
	output.x=-impulse
	output.y=-(impulse/3)
	return output

func die():
	velocity = Vector2(0,0)
	_animated_sprite.play("death")
	get_node("dienoise").playing=true
	await( _animated_sprite.animation_finished)
	PlayerData.deaths+=1
	is_dead=false
	queue_free()

func wallcling():
	if PlayerData.get_wallcling():
		can_jump=true
		if velocity.y>=0:
			velocity.y=min(velocity.y+wall_slide_acceleration, max_wall_slide_speed)


func _on_savedetector_area_entered(area):
	PlayerData.set_allow_save(true)

func _on_savedetector_area_exited(area):
	PlayerData.set_allow_save(false)

func _ready():
	if(PlayerData.get_exit_shop()):
		position.x=9253
		print("position: " +str(position.x))
		PlayerData.set_exit_shop(false)
