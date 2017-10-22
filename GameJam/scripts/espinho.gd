extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_espinho_body_enter( body ):
	if body.is_in_group(game.GRUPO_HEROI) && body.get_name():
		if body.has_method("gerarGhost"):
			game.morreu = true
			print("heroi morto")
	pass # replace with function body
