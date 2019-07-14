extends Sprite

var screen_size

func _ready():
	screen_size = get_viewport_rect().size

	pass

func _process(delta):
	position.x = position.x - 1

	if global_position.x < -300:
		global_position.x = 900