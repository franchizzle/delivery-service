extends Area2D

export var MAX_SPEED = 600  # How fast the player will move (pixels/sec).

const PACKAGE = preload("res://Package.tscn")
const RELOAD_TIME = 0.1
const ACCELERATION = 200
const GRAVITY = 200

var screen_size  # Size of the game window.
var sprite_frame
var sprite_size
var reloading = 0.0


func _ready():
	screen_size = get_viewport_rect().size
	sprite_frame = get_node("witch").frames.get_frame("default", 0)
	sprite_size = sprite_frame.get_size()
	pass

func _process(delta):
	move(delta)
	
	reloading -= delta
	
	if Input.is_key_pressed(KEY_SPACE):
		drop()



func move(delta):
	var velocity = Vector2()  # The player's movement vector.
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += ACCELERATION
		velocity.x = min(velocity.x, MAX_SPEED)
	if Input.is_action_pressed("ui_left"):
		velocity.x -= ACCELERATION
		velocity.x = min(velocity.x, MAX_SPEED)
	if Input.is_action_pressed("ui_down"):
		velocity.y += ACCELERATION
		velocity.y = min(velocity.y, MAX_SPEED)
	if Input.is_action_pressed("ui_up"):
		velocity.y -= ACCELERATION*6
		velocity.y = min(velocity.y, MAX_SPEED)
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * MAX_SPEED
		$witch.play()
	else:
		$witch.stop()

	position += velocity * delta
	position.x = clamp(position.x, 100, screen_size.x - 100)
	position.y = clamp(position.y, 70, screen_size.y - 70)
	
	# add gravity
	position.y += GRAVITY * delta
	
	if velocity.x != 0:
		$witch.flip_v = false
		$witch.flip_h = velocity.x < 0
	
func drop():
	if reloading <= 0.0:
		var package = PACKAGE.instance()
		package.set_position(Vector2(global_position.x, global_position.y))
		get_parent().add_child(package)
		reloading = RELOAD_TIME