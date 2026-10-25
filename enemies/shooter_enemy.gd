extends CharacterBody2D

var enemy_death_effect = preload("res://enemy_death_effect.tscn")
var shooter_enemy_bullet = preload("res://shooter_enemy_bullet.tscn")

@export var health_amount : int = 3
@onready var muzzle: Marker2D = $Muzzle
@onready var shoot_timer: Timer = $ShootTimer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


const SPEED = 300.0
const GRAVITY = 1000.0
var damage : int = 1


var player : Node2D = null

func _ready() -> void:
	find_player()
	shoot_timer.start()
	# shoot_timer.timeout.connect(_on_shoot_timer_timeout)

func _physics_process(delta : float) -> void:
	var current_player = get_tree().get_first_node_in_group("MainCharacter") as Node2D

	if current_player:
		if current_player.global_position.x < global_position.x:
			animated_sprite_2d.flip_h = true
		else:
			animated_sprite_2d.flip_h = false
		muzzle.look_at(current_player.global_position)
		
	if !is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		velocity.y = 0
	move_and_slide()

func _on_shoot_timer_timeout() -> void:
	print("Timer timed out!")
	shoot()
	
func shoot() -> void:
	if not player:
		return
	var bullet = shooter_enemy_bullet.instantiate()
	bullet.global_position = muzzle.global_position
	var dir = (player.global_position - muzzle.global_position).normalized()
	bullet.direction = dir
	get_tree().current_scene.add_child(bullet)


func _on_hurtbox_area_entered(area: Area2D) -> void:
	print("Hurtbox area entered")
	if area.get_parent().has_method("get_damage_amount"):
		var node = area.get_parent() as Node
		health_amount -= node.damage_amount
		print("Health amount: ", health_amount)
		if health_amount <= 0:
			var enemy_death_effect_instance = enemy_death_effect.instantiate() as Node2D
			enemy_death_effect_instance.global_position = global_position
			get_parent().add_child(enemy_death_effect_instance)
			queue_free()

func find_player():
	var nodes = get_tree().get_nodes_in_group("MainCharacter")
	
	for node in nodes:
		if node is CharacterBody2D:
			player = node
			return
		else:
			player = null
