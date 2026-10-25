extends BossState
class_name BossIdle

var player: CharacterBody2D
@export var final_boss: CharacterBody2D

func Enter():
	find_player()
	
func Update(delta: float):
	pass
	
func Physics_Update(delta: float):
	var direction = player.global_position - final_boss.global_position
	
	if direction.length() < 75:
		Transitioned.emit(self, "walk")
		
		
func find_player():
	var nodes = get_tree().get_nodes_in_group("MainCharacter")
	print("Nodes found in 'MainCharacter' group: ", nodes)
	
	for node in nodes:
		if node is CharacterBody2D:
			player = node
			return
		else:
			player = null
