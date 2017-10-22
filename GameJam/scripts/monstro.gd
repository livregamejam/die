extends Area2D

const TAM_X = 1024
const TAM_Y = 720

var vel = 50
var vida = 3

func _ready():
	add_to_group(game.GRUPO_INIMIGO)
	randomize()
	set_process(true)
	pass
	
func _process(delta):
	set_pos(get_pos() + Vector2(-1,0) * vel * delta)
	
	if get_pos().x < -30:
		queue_free()
		pass
	pass

func aplica_dano(valor):
	get_node("anim").play("hit")
	vida -= valor
	if vida <= 0:
		remove_from_group(game.GRUPO_INIMIGO)
		get_node("anim").play("destroy")
	pass