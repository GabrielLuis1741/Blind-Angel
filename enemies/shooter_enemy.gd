extends CharacterBody2D

const SPEED = 300.0
const GRAVITY = 1000.0
@export var damage_amount = 1

func _physics_process(delta):
	if !is_on_floor():
		velocity.y += GRAVITY * delta
		
	
