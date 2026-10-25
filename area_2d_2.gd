extends Area2D

var player: CharacterBody2D = null
@onready var boss_music: AudioStreamPlayer = $"../BossMusic"
@onready var audio_stream_player: AudioStreamPlayer = $"../AudioStreamPlayer"

func _on_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("MainCharacter"):
		audio_stream_player.stop()
		boss_music.play()
