extends KinematicBody2D


export (int) var speed = 250
export (int) var gravity = 1600
export (int) var jump_speed = -420

var velocity = Vector2.ZERO 
func _ready():
	$AnimationPlayer.play("Idle")
func get_input ():
	velocity.x = 0
	if Input.is_action_pressed("right"):
		velocity.x += speed
		$AnimationPlayer.play("Run")
	if Input.is_action_just_released("right"):
		$AnimationPlayer.play("Idle")
	if Input.is_action_pressed("left"):
		velocity.x -= speed
		$AnimationPlayer.play("Run")
	if Input.is_action_just_released("left"):
		$AnimationPlayer.play("Idle")
	if velocity.x < 0:
		$Sprite.flip_h = true
	if velocity.x > 0:
		$Sprite.flip_h = false
	if Input.is_action_just_pressed("attack"):
		$AnimationPlayer.play("Attack")
	yield ($AnimationPlayer, "animation_finished")
	$AnimationPlayer.play("Idle")


func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity,Vector2.UP)
	if Input.is_action_just_pressed("up"):
		if is_on_floor():
			velocity.y = jump_speed
			$AnimationPlayer.play("jump")
	if Input.is_action_just_released("up"):
		$AnimationPlayer.play("Idle")
	if velocity.x == 0: 
		velocity.x = 0
















func _on_PunchHit_area_entered(area):
	if area.is_in_group("hurtbox"):
		area.take_damage()
