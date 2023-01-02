extends Panel

@onready var tower = preload("res://Towers/RedBullet.tscn")

func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_mask == 1:
		var tempTower = tower.instantiate()
		add_child(tempTower)
		tempTower.global_position = event.global_position
		tempTower.process_mode = Node.PROCESS_MODE_DISABLED
	if event is InputEventMouseMotion and event.button_mask == 1:
		#button left down and dragging
		get_child(1).global_position = event.global_position
		get_child(1).scale = Vector2(0.32,0.32)
	if event is InputEventMouseButton and event.button_mask == 0:
		#button left release
		get_child(1).queue_free()
		print(event.global_position)
		var tempTower = tower.instantiate()
		var path = get_tree().get_root().get_node("Main/Towers")
		
		path.add_child(tempTower)
		tempTower.global_position = event.global_position
		tempTower.get_node("Area").hide()
