extends Node

export(NodePath) onready var player = get_node("..") as KinematicBody2D



onready var normal_sprite = get_node("NormalSprite")
onready var shoot_sprite = get_node("ShootSprite")
onready var particles = $ChargeParticles
onready var animation = $"../AnimationPlayer2"

var unique : bool = false
var hurt = false

func _animate() -> void:
	_flip_and_visible()
	if player.super_charge == false:
		if player.medium_charge == false:
			if player.is_charging == true:
				player.testing.play("Charge_1", -1, 0.5, false)
			else:
				player.testing.play('None')
				particles.emitting = false
		else:
				player.testing.play("Charge_1", -1, 1.0, false)
				particles.emitting = true
	else:
		player.testing.play('Super_charge', -1, 1.0, false)
	
	if player.can_play == true:
		if player.is_alive == true:
			if player.hitted == false:
				if player.AstroCrush == false:
					animation.play('None', -1, 0.5, false)
					if player.modo == "normal": #define que estams no modo normal e define série de animações
						if player.is_on_floor():
							if player.is_dashing == true and player.is_on_floor():
								normal_sprite.play("Dash")
								shoot_sprite.play("Dash")
							elif player.velocity.x > 49 or player.velocity.x < -49:
								normal_sprite.play('Run')
								shoot_sprite.play("Run")
							elif player.velocity.x == 0 and player.hurt == false:
								normal_sprite.play("Idle")
								shoot_sprite.play("Idle")
							elif player.velocity.x == 0 and player.hurt == true:
								normal_sprite.play("Idle")
								shoot_sprite.play("Idle")
							
						elif player.velocity.y < 0:
							normal_sprite.play("Jump")
							shoot_sprite.play("Jump")
						elif player.velocity.y > 0:
							normal_sprite.play("Fall")
							shoot_sprite.play("Fall")
				else:
					if hurt == true:
						shoot_sprite.play("Hurt")
						animation.play('Alert', -1, 0.5, false)
					else:
						shoot_sprite.play("AstroCrush")
			else:
				normal_sprite.play("Hit")
				shoot_sprite.play("Hit")
		else:
			normal_sprite.scale.y = 3.5
			normal_sprite.scale.x = 3.5
			shoot_sprite.scale.x = 3.5
			shoot_sprite.scale.y = 3.5
			normal_sprite.play("Die")
			shoot_sprite.play("Die")
	elif player.can_play == false:
		if !player.is_on_floor():
			normal_sprite.play("Intro1")
		else:
			normal_sprite.play("Intro2")
			player.velocity.y = 0

func _flip_and_visible() -> void:
	normal_sprite.flip_h = true if player.direction != 1 else false #Muda direção do sprite
	shoot_sprite.flip_h = true if player.direction != 1 else false
	player.hero_direction = 1 if normal_sprite.flip_h == false else 0 #Serve para definir a direção da saída do tiro
	if player.s == "s":
		normal_sprite.visible = false
		shoot_sprite.visible = true
	else:
		normal_sprite.visible = true
		shoot_sprite.visible = false


	
