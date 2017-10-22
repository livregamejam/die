extends StaticBody2D

func _ready():
	pass




func _on_portinha_laranja_area_body_enter( body ):
	if body.is_in_group(game.GRUPO_HEROI):
		if game.chaveLaranja == true:
			print("destrancando")
	pass # replace with function body
