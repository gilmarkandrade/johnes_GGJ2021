extends TileMap

export (bool) var random_active = false
export (int) var numero_de_fases_na_pasta = 1
var image = load("res://levels/teste.png").get_data()
export(int) var imagem_selecionada_para_teste = 1
var enemy1 = preload("res://enemies/skull/Archer_skull.tscn").instance()


func _ready():
	
	if random_active :
		select_image()
			
	else:
		var path = ("res://levels/"+str(imagem_selecionada_para_teste)+".png")
		image = load(path).get_data()
		yield(get_tree().create_timer(0.3),"timeout")
		generate_room()


func select_image():
	
	var rgn = RandomNumberGenerator.new()
	rgn.randomize()
	var image_selected = rgn.randi_range(1,numero_de_fases_na_pasta)
	var path = ("res://levels/"+str(image_selected)+".png")
	image = load(path).get_data()
	yield(get_tree().create_timer(0.3),"timeout")
	generate_room()

func generate_room():
	
	image.lock()
	for x in image.get_size().x: # escolhe um numero em x e passa para coluna em y para ser varrida
		for y in image.get_size().y:# quando termina passa para proximo lina de x para voltar fazer a varredura em x 
			
			
			var pixel = image.get_pixel(x,y)
			var pixel_pos:Vector2 = Vector2(x,y)
			
			match pixel:
				Color(0,0,0,1): #preto
					set_cell(pixel_pos.x,pixel_pos.y,1)
					set_cell(pixel_pos.x, pixel_pos.y , 1, false,  false,false, Vector2( 1, 0))
					
				Color(1,0,0,1):#vermelho
					set_cell(pixel_pos.x,pixel_pos.y,2)
					var e1 = enemy1.get_parent().add_child(enemy1)
					e1.position = pixel_pos
