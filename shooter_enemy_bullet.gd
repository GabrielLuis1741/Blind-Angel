extends Area2D

var speed : float = 300.0
var direction : Vector2 = Vector2.ZERO
var damage : int = 1

func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		HealthManager.take_damage(damage)
		queue_free()
	elif !body.is_in_group("enemy"):
		queue_free()
