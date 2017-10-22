extends Area2D


var ativado = false
onready var bar = 0
func _ready():
	set_process(true)
	pass
	
	
func _process(delta):
	if(get_node("CollisionPolygon2D").acionado):
		get_node("botao").set_animation("Acionado")
		get_node("botao").play()
		ativado = true
	else:
		get_node("botao").set_animation("Nacionado")
		get_node("botao").play()
		ativado = false
	
	pass
	


	