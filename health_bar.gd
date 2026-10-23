extends Node2D

@export var heart1 : Texture2D
@export var heart0 : Texture2D

@onready var heart_1 = $heart1
@onready var heart_2 = $heart2
@onready var heart_3 = $heart3

func _ready():
	HealthManager.on_health_change.connect(on_player_health_change)
	
func on_player_health_change(player_current_health : int):
	if player_current_health == 3:
		heart_3.texture = heart1
	elif player_current_health < 3:
		heart_3.texture = heart0
		
	if player_current_health == 2:
		heart_2.texture = heart1
	elif player_current_health < 2:
		heart_2.texture = heart0
		
	if player_current_health == 1:
		heart_1.texture = heart1
	elif player_current_health < 1:
		heart_1.texture = heart0
		
		
