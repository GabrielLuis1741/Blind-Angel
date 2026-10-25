extends BossState
class_name BossWalk

@export var final_boss: FinalBoss
@export var move_speed = 40.0
var player : CharacterBody2D

func Enter():
	print("Entered BossWalk state")
	find_player()
	
func Physics_Update(delta: float):
	find_player()
	
	if not player:
		find_player()
		return
		
	print("Player pos: ", player.global_position, " | Boss pos: ", final_boss.global_position)	
	var direction = player.global_position - final_boss.global_position
	print("Calculated direction length: ", direction.length())
	
	if direction.length() > 75:
		final_boss.velocity = direction.normalized() * move_speed
	else:
		final_boss.velocity = Vector2() 
	final_boss.move_and_slide()
	
	if direction.length() > 200:
		Transitioned.emit(self, "idle")
	
	elif direction.length() < 70:
		Transitioned.emit(self, "attack1")

func find_player():
	var nodes = get_tree().get_nodes_in_group("MainCharacter")
	print("Nodes found in 'MainCharacter' group: ", nodes)
	
	for node in nodes:
		if node is CharacterBody2D:
			player = node
			return
		else:
			player = null
			
