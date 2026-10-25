extends BossState
class_name BossAttack1

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var attack_box: Area2D = $"../../AttackBox"

@export var final_boss: FinalBoss
@export var move_speed = 40.0
var player : CharacterBody2D
var has_dealt_damage : bool = false

func Enter():
	print("Entered Boss Attack 1 state")
	find_player()
	
func Physics_Update(delta: float):
	find_player()
	
	if not player:
		find_player()
		return
		
	var direction = player.global_position - final_boss.global_position
	
	if direction.length() > 30:
		Transitioned.emit(self, "walk")
		return
		
	final_boss.velocity = Vector2.ZERO
	 
	final_boss.move_and_slide()
	animated_sprite_2d.play("attack1")

	if animated_sprite_2d.animation == "attack1":
		if animated_sprite_2d.frame == 8 and not has_dealt_damage:
			final_boss.deal_attack_damage()
			has_dealt_damage = true
		elif animated_sprite_2d.frame != 8:
			has_dealt_damage = false 
			
func find_player():
	var nodes = get_tree().get_nodes_in_group("MainCharacter")
	print("Nodes found in 'MainCharacter' group: ", nodes)
	
	for node in nodes:
		if node is CharacterBody2D:
			player = node
			return
		else:
			player = null
