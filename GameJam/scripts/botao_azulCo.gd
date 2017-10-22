extends CollisionPolygon2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var acionado = false
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass





func _on_botao_azul_body_enter( body ):
	if(body.is_in_group(game.GRUPO_HEROI)):
		acionado =  true
	else:
		acionado = false


func _on_botao_azul_body_exit( body ):
	if(body.is_in_group(game.GRUPO_HEROI)):
		acionado =  false
	pass # replace with function body
