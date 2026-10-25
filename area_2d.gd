extends Area2D

var player: CharacterBody2D = null

func _on_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("MainCharacter"):
		get_tree().change_scene_to_file("res://win_screen.tscn")
