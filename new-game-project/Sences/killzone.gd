extends Area2D

@onready var timer = $Timer
@onready var player = $CharacterBody2D


func _on_body_entered(body: Node2D) -> void:
	print("You Have Died!")
	timer.start()
	
func _on_timer_timeout()-> void:
	get_tree().reload_current_scene()
