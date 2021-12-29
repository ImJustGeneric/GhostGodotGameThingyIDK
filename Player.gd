extends KinematicBody2D



export var speed = 24000
export var mana_idle = 150
export var mana_ghost = 5
export var mana_possessed = 25

var ghost = false
var velocity = Vector2.ZERO
var can_possess =  false
var in_own_body = true
var mana = 0



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
	if Input.is_action_just_pressed("space") and !can_possess:
		ghost = !ghost
	elif Input.is_action_just_pressed("space"):
		in_own_body = false
		$Sprite.hide()
		$CollisionShape2D.disabled = true

	velocity = velocity.normalized() * speed 

func _physics_process(delta):
	if in_own_body:
		get_input()
		if ghost:
			$Sprite.frame = 1
			$CollisionShape2D.disabled = true
			mana -= mana_ghost*delta
			if mana <= 0:
				ghost = !ghost
		else:
			$Sprite.frame = 0
			$CollisionShape2D.disabled = false
			mana += mana_idle*delta
		if mana > 100:
			mana = 100
		velocity = move_and_slide(velocity*delta)
	else:
		mana -= mana_possessed*delta
