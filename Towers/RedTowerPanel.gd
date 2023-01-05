extends Panel

@onready var tower = preload("res://Towers/RedBullet.tscn")
var currTile

func _on_gui_input(event):
	if Game.Gold >= 10:
		var tempTower = tower.instantiate()
		if event is InputEventMouseButton and event.button_mask == 1:
			
			add_child(tempTower)
			tempTower.global_position = event.global_position
			#tempTower.process_mode = Node.PROCESS_MODE_DISABLED
			
			tempTower.scale = Vector2(0.32,0.32)
		
		elif event is InputEventMouseMotion and event.button_mask == 1:
			#button left down and dragging
			if get_child_count() > 1:
				
				get_child(1).global_position = event.global_position
				#Check if on Dirt Tile.
				var mapPath = get_tree().get_root().get_node("Main/TileMap")
				var tile = mapPath.local_to_map(get_global_mouse_position())
				currTile = mapPath.get_cell_atlas_coords(0, tile, false)
				var targets = get_child(1).get_node("TowerDetector").get_overlapping_bodies()
				if (currTile == Vector2i(4,5)):
					if (targets.size() > 1):
						get_child(1).get_node("Area").modulate = Color(255,255,255)
					else:
						get_child(1).get_node("Area").modulate = Color(0,255,0)
				else:
					
					get_child(1).get_node("Area").modulate = Color(255,255,255)
		elif event is InputEventMouseButton and event.button_mask == 0:
			#button left release
			if event.global_position.x >= 2944:
				if get_child_count() > 1:
					get_child(1).queue_free()
			else:
				#check for valid tile:
				if get_child_count() > 1:
					get_child(1).queue_free()
				if currTile == Vector2i(4,5):
					var targets = get_child(1).get_node("TowerDetector").get_overlapping_bodies()
					var path = get_tree().get_root().get_node("Main/Towers")
					if (targets.size() < 2):
						path.add_child(tempTower)
						tempTower.global_position = event.global_position
						tempTower.get_node("Area").hide()
						Game.Gold -= 10
		else:
			if get_child_count() > 1:
				get_child(1).queue_free()
