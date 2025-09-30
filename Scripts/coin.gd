extends Area2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@onready var coin_sfx: AudioStreamPlayer2D = $coin
@onready var animation_player: AnimationPlayer = $AnimationPlayer





func _on_body_entered(body: CharacterBody2D) -> void:
	print("+1 Coin!")
	animation_player.play("pickup")
	
	

	
