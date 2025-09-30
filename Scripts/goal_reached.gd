extends Area2D


@onready var power_up: AudioStreamPlayer = $PowerUp

@onready var timer: Timer = $Timer
@onready var animation_player_2: AnimationPlayer = $AnimationPlayer2



func _on_body_entered(body: CharacterBody2D) -> void:
	print("Goal 1 Reached!")
	$PowerUp.play()
	timer.start()
	
	
	


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/level_2.tscn")
