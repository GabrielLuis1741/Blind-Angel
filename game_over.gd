extends Node2D

var button_type = null

@onready var button_sfx: AudioStreamPlayer = $ButtonManager/ButtonSFX
@onready var click_sfx: AudioStreamPlayer = $ButtonManager/ClickSFX

func _on_retry_pressed() -> void:
	click_sfx.play()
	get_tree().change_scene_to_file("res://test_level.tscn")

func _on_quit_pressed() -> void:
	click_sfx.play()
	get_tree().quit()

func _on_retry_mouse_entered() -> void:
	button_sfx.play()

func _on_quit_mouse_entered() -> void:
	button_sfx.play()
