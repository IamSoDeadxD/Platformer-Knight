extends CharacterBody2D


var player_speed = 150.0
const JUMP_VELOCITY = -350.0
@onready var sprite = $Player
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var timer: Timer = $Timer

@onready var animation_player_2: AnimationPlayer = $AnimationPlayer2
var is_dead = false
	
func _physics_process(delta: float) -> void:
	if is_dead:
		# --- DEAD LOGIC ---
		# When dead, we only apply gravity and let the body fall.
		# We do NOT check for input or set any other animations.
		# This allows the 'death' animation to play without interruption.
		pass
	
	# Add the gravity.
	else:
		if not is_on_floor():
			velocity += get_gravity() * delta

		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
		
			$AudioStreamPlayer2D.play()
			velocity.y = JUMP_VELOCITY
			

		var direction = Input.get_axis("move_left","move_right")


		if Input.is_action_pressed("sprint"):
			if is_on_floor():
				player_speed = 250
			else:
				player_speed = 150
		else:
			player_speed = 150

		
		if is_on_floor():
			if direction == 0:
				animated_sprite_2d.play("idle")
			else:
				animated_sprite_2d.play("run")
		else:
			animated_sprite_2d.play("jump")
		
		

		if direction > 0:
			animated_sprite_2d.flip_h = false
		if direction < 0:
			animated_sprite_2d.flip_h = true
				
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		if direction:
			velocity.x = player_speed * direction
		else:
			velocity.x = move_toward(velocity.x,0,player_speed)
			

		move_and_slide()




	
func _on_spikes_body_entered(body: CharacterBody2D) -> void:
	if not is_dead: # This prevents the function from running multiple times
		is_dead = true
		animation_player_2.play('death')
		timer.start()

	

func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()


func _on_goal_reached_body_entered(body: CharacterBody2D) -> void:
	animation_player_2.play("Goal Reaached")
