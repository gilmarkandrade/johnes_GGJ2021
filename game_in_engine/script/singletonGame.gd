extends Node
var player_position = Vector2()
var get_key = false



func update_pos_player(value:Vector2):
	player_position = value

func update_key(value:bool):
	get_key = value
	print(get_key)
