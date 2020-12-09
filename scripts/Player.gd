extends KinematicBody2D

export var speed = 500
export var jumpSpeed = 1000
export var gravity = 50

var _velocity = Vector2.ZERO
var _jumpCount = 0

const UP = Vector2.UP


func _ready():
	pass


func _physics_process(delta):
	_move()
	_jump()
	_animate()
	_apply_gravity()
	move_and_slide(_velocity, UP)

func _move():
	if Input.is_action_pressed("left") && not Input.is_action_pressed("right"):
		_velocity.x = -speed
	elif Input.is_action_pressed("right") && not Input.is_action_pressed("left"):
		_velocity.x = speed
	else:
		_velocity.x = 0


func _jump():
	if Input.is_action_just_pressed("jump") and _jumpCount < 2:
		_velocity.y = -jumpSpeed
		_jumpCount += 1
	elif is_on_floor():
		_jumpCount = 0



func _apply_gravity():
	if not is_on_floor():
		_velocity.y += gravity


func _animate():
	if _velocity.y < 0:
		$AnimatedSprite.play("jump")
	elif _velocity.x != 0 and _velocity.x > 0:
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = false
	elif _velocity.x != 0 and _velocity.x < 0:
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.play("idle")
