extends KinematicBody2D

export var MAX_SPEED = 400  # How fast the player will move (pixels/sec).
const UP = Vector2(0, -1)

#const RELOAD_TIME = 0.1
const ACCELERATION = 30
const GRAVITY = 20

var screen_size  # Size of the game window.
var sprite_frame
var sprite_size
#var reloading = 0.0


func _ready():
	screen_size = get_viewport_rect().size
	pass

func _physics_process(delta):
	move(delta)
	#reloading -= delta

var velocity = Vector2()  # The player's movement vector.

func move(delta):
	
	velocity.y += GRAVITY

	if Input.is_action_pressed("ui_right"):
		velocity.x += ACCELERATION
		velocity.x = min(velocity.x, MAX_SPEED)
	if Input.is_action_pressed("ui_left"):
		velocity.x -= ACCELERATION
		velocity.x = min(velocity.x, MAX_SPEED)
	if Input.is_action_pressed("ui_down"):
		velocity.y += ACCELERATION*2
		velocity.y = min(velocity.y, MAX_SPEED)
	if Input.is_action_pressed("ui_up"):
		velocity.y -= ACCELERATION*2
		velocity.y = min(velocity.y, MAX_SPEED)
	
	#if velocity.length() > 0:
	#	velocity = velocity.normalized() * MAX_SPEED
	#else:
    #    velocity = velocity

	move_and_slide(velocity, UP)
	
	position.x = clamp(position.x, 110, screen_size.x - 100)
	position.y = clamp(position.y, 75, screen_size.y - 75)
	
	# add gravity
	#position.y += GRAVITY * delta
	
	if velocity.x != 0:
		$Witch.flip_v = false
		$Witch.flip_h = velocity.x < 0
	
