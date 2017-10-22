extends StaticBody2D

onready var btn_azul = get_node("botao_azul")
var abaixada = 0

func _ready():
	set_process(true)
	pass

#Legenda abaixada:
	# 0 - escada la em cima, pode abaixar se quiser (vai pra 1)
	# 1 - escada acionada para abaixar (vai pra 2)
	# 2 - escada abaixando (vai pra 3)
	# 3 - escada la em baixo, pode subir se quiser (vai pra 4)
	# 4 - escada acionada para subir (vai pra 5)
	# 5 - escada subindo (vai pra 0)

func _process(delta):
	if btn_azul.ativado && abaixada == 0:
		abaixada = 1 #pronta para abaixar
	
	if abaixada == 1:
		get_node("anim").play("escada_descendo")
		abaixada = 2 #abaixando 
		
	if abaixada == 2 && !get_node("anim").is_playing() :
		abaixada = 3 #totalmente abaixada, pode subir
		
	if !btn_azul.ativado && abaixada == 3:
		abaixada = 4 #pronta para subir
	
	if abaixada == 4:
		get_node("anim").play("escada_subindo")
		abaixada = 5 #subindo 
	
	if abaixada == 5 && !get_node("anim").is_playing() :
		abaixada = 0 #totalmente la em cima, pode descer
		
	pass

func _on_escada_area_body_enter( body ):
	esta_subindo_escada(body)
	pass # replace with function body


func _on_escada_area1_body_enter( body ):
	esta_subindo_escada(body)
	pass # replace with function body


func _on_escada_area2_body_enter( body ):
	esta_subindo_escada(body)
	pass # replace with function body

func esta_subindo_escada(body):
	if body.is_in_group(game.GRUPO_HEROI):
		body.subir_escada()
		pass
	pass