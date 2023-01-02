extends CharacterBody2D


var target
var Speed = 1000
var pathName = ""
var bulletDamage

func _physics_process(delta):
	
	var pathSpawnerNode = get_tree().get_root().get_node("Main/PathSpawner")
	for i in pathSpawnerNode.get_child_count():
		if pathSpawnerNode.get_child(i).name == pathName:
			target = pathSpawnerNode.get_child(i).get_child(0).get_child(0).global_position

	velocity = global_position.direction_to(target) *Speed

	look_at(target)
	
	move_and_slide()

func _on_collision_body_entered(body):
	if "Solider A" in body.name:
		body.Health -= bulletDamage
		queue_free()
		
