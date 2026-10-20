extends Node2D


const BEAM = preload("res://light_beam.tscn")
@onready var tip: Marker2D = $Sprite2D/Marker2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 && rotation_degrees < 270 :
		scale.y = -1
	else:
		scale.y = 1
	if Input.is_action_just_pressed("fire"):
		var bullet_instance = BEAM.instantiate()
		get_tree().root.add_child(bullet_instance)
		bullet_instance.global_position = tip.global_position
		bullet_instance.rotation = rotation
