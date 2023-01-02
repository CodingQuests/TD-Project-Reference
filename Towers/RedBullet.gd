extends StaticBody2D

var Bullet = preload("res://Towers/Bullet.tscn")
var bulletDamage = 5
var pathName
var currTargets = []
var curr

func _process(delta):
	if is_instance_valid(curr):
		self.look_at(curr.global_position)
	else:
		for i in get_node("BulletContainer").get_child_count():
			get_node("BulletContainer").get_child(i).queue_free()

func _on_tower_body_entered(body):
	if "Solider A" in body.name:
		var tempArray = []
		currTargets = get_node("Tower").get_overlapping_bodies()
		for i in currTargets:
			if "Solider" in i.name:
				tempArray.append(i)
		
		var currTarget = null
		for i in tempArray:
			if currTarget == null:
				currTarget = i.get_node("../")
			else:
				if i.get_parent().get_progress() > currTarget.get_progress():
					currTarget = i.get_node("../")
		
		curr = currTarget
		pathName = currTarget.get_parent().name
		
		var tempBullet = Bullet.instantiate()
		tempBullet.pathName = pathName
		tempBullet.bulletDamage = bulletDamage
		get_node("BulletContainer").add_child(tempBullet)
		tempBullet.global_position = $Aim.global_position
		
		#await get_tree().create_timer(1).timeout

func _on_tower_body_exited(body):
	currTargets = get_node("Tower").get_overlapping_bodies()
