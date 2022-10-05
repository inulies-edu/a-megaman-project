extends KinematicBody2D

var velocity: Vector2
var direction: int

export(int) var walk_speed
export(int) var gravity
export(int) var jump_force
export(float) var acceleration
export(float) var friction

onready var animated_sprite: AnimatedSprite = get_node("AnimatedSprite")

func _physics_process(delta: float) -> void:
	move()
	jump()
	animate()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	print(velocity.x)
	


func move() -> void:
	var vx = -int(Input.is_action_pressed("move_left")) +  int(Input.is_action_pressed("move_right"))
	if vx != 0:
		velocity.x = lerp(velocity.x, vx * walk_speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)

func jump() -> void:
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += -jump_force



func animate():
	change_direction()
	if !is_on_floor():
		jump_animation()
	else:
		move_animation()

func change_direction() -> void:
	if velocity.x > 0:
		animated_sprite.flip_h = false
	elif velocity.x < 0:
		animated_sprite.flip_h = true

func jump_animation() -> void:
	if velocity.y > 0:
		animated_sprite.play('Fall')
	elif velocity.y < 0:
		animated_sprite.play('Jump')

func move_animation() -> void:
	if velocity.x != 0:
		animated_sprite.play('Run')
	elif velocity.x == 0:
		animated_sprite.play('Idle')


