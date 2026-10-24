extends PointLight2D

@export var light_frames:Array[Texture2D] = []
@export var fps: float = 7

var current_frame: float = 0.0

func _process(delta: float) -> void:
	if light_frames.is_empty():
		return
	
	current_frame += fps * delta
	var frame_index = int(current_frame) % light_frames.size()
	
	texture = light_frames[frame_index]
