extends CanvasLayer


export(NodePath) onready var rockman = get_node("..") as KinematicBody2D
onready var hud = get_node("Lifebar")
onready var lifes = get_node("Label")

func _physics_process(delta):
	lifes.text = String(player.lives)
	if player.health == 4:
		hud.frame = 0
	elif player.health == 3:
		hud.frame = 1
	elif player.health == 2:
		hud.frame = 2
	elif player.health == 1:
		hud.frame = 3
	elif player.health == 0:
		hud.frame = 4
