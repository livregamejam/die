extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var bar = 0
var ativado = false
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
	


	