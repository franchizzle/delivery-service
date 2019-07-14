extends Sprite

const VELOCITY = Vector2(0, 300)
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	$packageArea.connect("area_entered", self, "hit")
	pass

func _process(delta):
	move(delta)
	removeWhenOffScreen()
	
func move(delta):
	global_position += VELOCITY * delta
	
func removeWhenOffScreen():
	if global_position.y > screen_size.y: 
		queue_free()
		
func hit(object):
	if object.name == "DropZone":
		get_node("/root/Main").add_point()