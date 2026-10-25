extends CharacterBody2D
class_name FinalBoss

var enemy_death_effect = preload("res://enemy_death_effect.tscn")
@onready var hurt_box: Area2D = $HurtBox
@onready var attack_box: Area2D = $AttackBox
const gravity = 1000

var damage = .25
var health_amount = 1

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	move_and_slide()
	
	if velocity.length() > 0:
		$AnimatedSprite2D.play("walk")
		
	elif velocity.length() == 0:
		if $AnimatedSprite2D.animation != "attack1" or "attack2":
	#check if enemy dead.. if not 
		# check if player has encountered boss yet
			# if yes:
			$AnimatedSprite2D.play("idle")
			# if no:
			# $AnimatedSprite2D.play("dormant")
	# if enemy is dead:
			# $AnimatedSprite2D.stop()
		
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true


#func _on_attack_box_body_entered(body: Node2D) -> void:
#	deal_attack_damage()
		
#func deal_attack_damage():
#	for body in attack_box.get_overlapping_bodies():
##			HealthManager.decrease_health(damage)
			
func _on_hurt_box_area_entered(area: Area2D) -> void:
	if hurt_box.get_parent().has_method("get_damage_amount"):
		var node = hurt_box.get_parent() as Node
		health_amount -= node.damage_amount
		print("Health amount: ", health_amount)
		if health_amount <= 0:
			var enemy_death_effect_instance = enemy_death_effect.instantiate() as Node2D
			enemy_death_effect_instance.global_position = global_position
			get_parent().add_child(enemy_death_effect_instance)
			queue_free()
