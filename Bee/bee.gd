extends CharacterBody2D


const SPEED = 3000.0
const JUMP_VELOCITY = -400.0

@onready var anim = get_node("Container/AnimatedSprite2D")
@onready var container = get_node("Container")
@onready var player = get_node("../Player")

var player_in_sight

func _ready():
	anim.play("Idle")

func _physics_process(delta: float) -> void:
	if player_in_sight:
		velocity = (player.position - self.position).normalized() * SPEED * delta

		if self.position.x > player.position.x:
			container.scale.x = 1
		elif self.position.x < player.position.x:
			container.scale.x = -1
	else:
		velocity = Vector2.ZERO
	move_and_slide()

# Xử lý va chạm thì load lại sence
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		call_deferred("_change_scene")
		
func _change_scene():
	get_tree().change_scene_to_file("res://world.tscn")

# Xử lý ở trong sight thì Bee mới bay lại tấn công
func _on_player_in_sight(body: Node2D) -> void:
	print("Đã phát hiện: ", body.name)
	if body.name == "Player":
		player_in_sight = true

# Xử lý ngoài sight thì Bee không đuổi nữa
func _on_sight_body_exited(body: Node2D) -> void:
	print("Player đã ra khỏi Sight")
	if body.name == "Player":
		player_in_sight = false
