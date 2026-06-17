class_name Player extends CharacterBody2D

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
var move_speed : float = 200.0
var state : String = "idle"

@onready var animation_player: AnimationPlayer = $Sprite2D/AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D


func _process (delta):
	
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	velocity = direction * move_speed
	if SetState() == true || SetDirection() == true:	
		UpdateAnimation()

func _physics_process(delta: float) -> void:
	move_and_slide()

func SetDirection() -> bool:
		
	return true

func SetState() -> bool:
	var new_state : String = "idle" if direction == Vector2.ZERO else "walk"
	if new_state == state:
		return false
	state = new_state
	return true
	
func UpdateAnimation() -> void:
	animation_player.play(state + "_" + AnimDirection())


func AnimDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "up"
	elif cardinal_direction == Vector2.UP:
		return "down"
	else:
		return "side"
