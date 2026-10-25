extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var fade_transition: ColorRect = $FadeTransition
@onready var fade_time: Timer = $FadeTransition/FadeTime
@onready var animation_player: AnimationPlayer = $FadeTransition/AnimationPlayer

var animation_queue: Array[String] = ["first_frame", "scene1", "scene2", "scene3", "scene4", "scene5", "scene6"]
var current_index: int = 0

func _ready() -> void:
	animated_sprite_2d.animation_finished.connect(_on_animated_sprite_2d_animation_finished)
	play_next_animation()

func play_next_animation():
	if current_index < animation_queue.size():
		var next_anim = animation_queue[current_index]
		animated_sprite_2d.play(next_anim)
		current_index += 1

func _on_animated_sprite_2d_animation_finished() -> void:
	play_next_animation()
	if current_index == animation_queue.size():
		fade_transition.show()
		fade_time.start()
		animation_player.play("fade_to_black")
		
func _on_fade_time_timeout():
		get_tree().change_scene_to_file("res://test_level.tscn")

func _on_skip_pressed() -> void:
		get_tree().change_scene_to_file("res://test_level.tscn")
