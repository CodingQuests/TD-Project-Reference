extends CharacterBody2D


@export var speed = 1000
var Health = 10
func _physics_process(delta):
	get_parent().set_progress(get_parent().get_progress() + speed*delta)
	
	if get_parent().get_progress_ratio() == 1:
		get_parent().get_parent().queue_free()
		
	if Health <= 0:
		get_parent().get_parent().queue_free()
