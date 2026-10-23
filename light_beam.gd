extends Node2D

var bullet_impact_effect = preload("res://bullet_impact_effect.tscn")
var damage_amount : int = 1

const SPEED: int = 700
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += transform.x * SPEED * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_hitbox_area_entered(area: Area2D) -> void:
	print("Bullet area entered")
	bullet_impact()

func _on_hitbox_body_entered(body: Node2D) -> void:
	print("Bullet body entered")
	bullet_impact()

func get_damage_amount() -> int:
	return damage_amount

func bullet_impact():
	var bullet_impact_effect_instance = bullet_impact_effect.instantiate() as Node2D
	bullet_impact_effect_instance.global_position = global_position
	get_parent().add_child(bullet_impact_effect_instance)
	queue_free()
