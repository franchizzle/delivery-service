extends Node

const DROPZONE = preload("res://DropZone.tscn")

func _ready():
	generate_drop_zones()
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func add_point():
	$UI/Score.update_score()
	
func generate_drop_zones():
	for i in range(10):
		var dropzone = DROPZONE.instance()
		var random =  1024*i + (i * 10 + randi() % 5)
		dropzone.set_position(Vector2(random, 550))
		add_child(dropzone)