extends CharacterBody2D

enum STATE{
	FALL,
	FLOOR,
	JUMP,
	DOUBLE_JUMP,
	FLOAT,
	LEDGE_CLIMB,
	LEDGE_JUMP,
}

const FALL_GRAVITY := 1500.0
const FALL_VELOCITY := 500.0
const WALK_VELOCITY := 200.0
const JUMP_VELOCITY := -600.0
const JUMP_DECELERATION := 1500.0

@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
@onready var coyote_timer: Timer = %CoyoteTimer

var active_state := STATE.FALL

func _ready() -> void:
	switch_state(active_state)

func _physics_process(delta: float) -> void:
	process_state(delta)
	move_and_slide()
	

func switch_state(to_state: STATE) -> void:
	var previous_state := active_state
	active_state = to_state
	
	## State specific things that need to run just once after entering the next state
	match  active_state:
		STATE.FALL:
			animated_sprite_2d.play("temp_idle")
			if previous_state == STATE.FLOOR:
				coyote_timer.start()
		STATE.JUMP: 
			animated_sprite_2d.play("temp_jump")
			velocity.y = JUMP_VELOCITY
			coyote_timer.stop()

func process_state(delta: float)	-> void:
	match active_state:
		STATE.FALL:
			velocity.y = move_toward(velocity.y, FALL_VELOCITY, FALL_GRAVITY * delta)
			handle_movement()
			
			if is_on_floor():
				switch_state(STATE.FLOOR)
			elif Input.is_action_just_pressed("jump") and coyote_timer.time_left > 0:
				switch_state(STATE.JUMP)
			
		STATE.FLOOR:	
			if Input.get_axis("move_left", "move_right"):
				animated_sprite_2d.play("temp_run")
			else:
				animated_sprite_2d.play("temp_idle")
		
			handle_movement()
			
			if not is_on_floor():
				switch_state(STATE.FALL)
			elif Input.is_action_just_pressed("jump"):
				switch_state(STATE.JUMP)	
		
		STATE.JUMP:
			velocity.y = move_toward(velocity.y, 0, JUMP_DECELERATION * delta)
			handle_movement()
			
			if Input.is_action_just_released("jump") or velocity.y >= 0:
				velocity.y = 0
				switch_state(STATE.FALL)



func handle_movement() -> void:
	var input_direction := signf(Input.get_axis("move_left", "move_right"))
	if input_direction:
		animated_sprite_2d.flip_h = input_direction < 0
	velocity.x = input_direction * WALK_VELOCITY	
	
	
	
