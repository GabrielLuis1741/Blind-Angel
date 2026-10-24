extends Node2D

var button_type = null

@onready var button_sfx: AudioStreamPlayer = $ButtonManager/ButtonSFX
@onready var click_sfx: AudioStreamPlayer = $ButtonManager/ClickSFX

func _on_start_pressed() -> void:
	click_sfx.play()
	button_type = "start"
	$FadeTransition.show()
	$FadeTransition/FadeTime.start()
	$FadeTransition/AnimationPlayer.play("fade_to_black")

func _on_options_pressed() -> void:
	click_sfx.play()
	button_type = "options"
	$FadeTransition.show()
	$FadeTransition/FadeTime.start()
	$FadeTransition/AnimationPlayer.play("fade_to_black")

func _on_quit_pressed() -> void:
	click_sfx.play()
	get_tree().quit()


func _on_fade_time_timeout() -> void:
	if button_type == "start":
		get_tree().change_scene_to_file("res://test_level.tscn")
	elif button_type == "options":
		get_tree().change_scene_to_file("res://volume.tscn")


func _on_start_mouse_entered() -> void:
	button_sfx.play()
	
func _on_options_mouse_entered() -> void:
	button_sfx.play()
	
func _on_quit_mouse_entered() -> void:
	button_sfx.play()
