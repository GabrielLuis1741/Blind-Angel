extends Node2D

var button_type = null

@onready var button_sfx: AudioStreamPlayer = $ButtonManager/ButtonSFX
@onready var click_sfx: AudioStreamPlayer = $ButtonManager/ClickSFX

func _on_quit_pressed() -> void:
	click_sfx.play()
	get_tree().quit()
