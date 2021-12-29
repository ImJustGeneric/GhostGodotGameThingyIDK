extends KinematicBody2D

onready var player = get_node("/root/World/Player")

export var ghost_area = 100
export var speed = 24000

var velocity = Vector2.ZERO
var player_controlled = false

func back_to_player():
	player_controlled = false
	$Sprite.frame = 0
	get_node("/root/World/Player/Sprite").show()
	get_node("/root/World/Player/CollisionShape2D").disabled = false
	player.in_own_body = true
	player.can_possess = false
	player.position = position



func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed('right'):
		velocity.x += 1
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	if Input.is_action_pressed('down'):
		velocity.y += 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1
	if Input.is_action_just_pressed("space"):
		back_to_player()
		
	velocity = velocity.normalized() * speed 

func _physics_process(delta):
	if !player_controlled:
		if player.ghost == true and player.position.x > position.x-ghost_area and player.position.x < position.x+ghost_area and player.position.y > position.y-ghost_area and player.position.y < position.y+ghost_area:
			$Sprite.frame = 1
			player.can_possess = true
			if Input.is_action_just_pressed("space"):
				player_controlled = true
				$Sprite.frame = 2
		else:
			$Sprite.frame = 0
			player.can_possess = false
	else:
		get_input()
		velocity = move_and_slide(velocity*delta)
		if player.mana < 0:
			back_to_player()
