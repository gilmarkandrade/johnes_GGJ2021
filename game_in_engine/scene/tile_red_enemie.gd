

var enemy1 = preload("res://enemies/skull/Archer_skull.tscn").instance()


func _ready():
	print("aqui")
	var e1 = enemy1.get_parent().add_child(enemy1)
	
