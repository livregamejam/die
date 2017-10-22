extends Area2D

const TAM_X = 1024
const TAM_Y = 720
var vetor = 1
var vel = 400

func _ready():
	set_process(true)
	pass

func _process(delta):
	set_pos(get_pos() + Vector2(vetor,0) * vel * delta)
	
	if get_pos().x > TAM_X || get_pos().x < 0:
		queue_free()
		pass
	
	pass

func _on_tiro_area_enter( area ):
	if area.is_in_group(game.GRUPO_INIMIGO):
		if area.has_method("aplica_dano"):
			area.aplica_dano(1)
		else:
			area.queue_free()
		queue_free()
		pass
	pass 