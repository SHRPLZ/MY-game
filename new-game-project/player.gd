extends CharacterBody2D

@onready var animated_sprite =$AnimatedSprite2D
@onready var coyote_timer:float = 0.25

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const JUMP_multiplyer = 1.05
var jump_available:bool= true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		if jump_available:
			get_tree().create_timer(coyote_timer).timeout.connect(coyote_timeout)
		
		velocity += get_gravity() * delta
	else:
		jump_available=true

	#if JUMP_VELOCITY < 0 && (is_on_floor() || !coyote_timer.is_stopped()):
		#velocity.y = JUMP_VELOCITY * JUMP_multiplyer

	# Handle jump.
	if Input.is_action_just_pressed("jump") and jump_available:
		velocity.y = JUMP_VELOCITY
		jump_available=false
		
		
	# Get the input direction: -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flip the spirte
	if direction > 0:
		animated_sprite.flip_h = false
	
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Play animations
	if direction == 0:
		animated_sprite.play("Idle")
	else:
		animated_sprite.play("Run")
		
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	var was_on_floor = is_on_floor()
	move_and_slide()
func coyote_timeout():
	jump_available=false
	
