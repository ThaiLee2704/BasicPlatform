extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -400.0

@onready var anim = get_node("Container/AnimatedSprite2D")
@onready var container = get_node("Container")

func _physics_process(delta: float) -> void:
	# Rơi do trọng lực
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Xử lý nhảy
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Xử lý di chuyển trái phải
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction == 1 or direction == -1:
		velocity.x = direction * SPEED
		container.scale.x = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Xử lý chuyển động
	if not is_on_floor():
		anim.play("Jump")
	elif direction == 1 or direction == -1:
		anim.play("Run")
	else:
		anim.play("Idle")	
	move_and_slide()
