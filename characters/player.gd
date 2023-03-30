extends CharacterBody2D

@export var movement_speed: float = 100
@export var starting_direction: Vector2 = Vector2(0,1)

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

func _ready():
	update_animation_parameters(starting_direction)

func _physics_process(_delta):
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	update_animation_parameters(input_direction)
	velocity = input_direction * movement_speed
	move_and_slide()
	
func update_animation_parameters(animation_direction: Vector2):
	if (animation_direction != Vector2.ZERO):
		animation_tree.set("parameters/idle/blend_position", animation_direction)
		animation_tree.set("parameters/run/blend_position", animation_direction)
		state_machine.travel("run")
	else:
		state_machine.travel("idle")
	
