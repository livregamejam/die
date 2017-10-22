extends Node

const TAM_X = 1024
const TAM_Y = 720

var pre_monstro = preload("res://scenes/monstro.tscn")
var intervalo= 2

func _ready():
	set_process(true)
	pass
	
func _process(delta):
	if intervalo > 0:
		intervalo -= delta
	else:
		intervalo = 2
		var monstro = pre_monstro.instance()
		monstro.set_pos(Vector2(rand_range(40,(TAM_X - 50)), (TAM_Y - 117)))
		get_owner().add_child(monstro)
	
	pass
