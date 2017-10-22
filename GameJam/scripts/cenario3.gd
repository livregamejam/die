extends StaticBody2D


onready var btn_ver = get_node("botao_verde")
onready var colyn_corda = get_node("colyn_corda")
onready var c1 = get_node("corda")
onready var c2 = get_node("corda1")
onready var c3 = get_node("corda2")
onready var c4 = get_node("corda3")
onready var c5 = get_node("corda4")
onready var c6 = get_node("corda5")

var pos_orig = 0

func _ready():
	set_process(true)
	pos_orig = colyn_corda.get_pos()
	pass

func _process(delta):
	if btn_ver.ativado:
		print("era pra abrir")
		colyn_corda.set_pos(Vector2(-1000,colyn_corda.get_pos().y))
		
		c1.set_opacity(0.2)
		c2.set_opacity(0.2)
		c3.set_opacity(0.2)
		c4.set_opacity(0.2)
		c5.set_opacity(0.2)
		c6.set_opacity(0.2)
	else :
		colyn_corda.set_pos(Vector2(pos_orig))
		
		c1.set_opacity(1)
		c2.set_opacity(1)
		c3.set_opacity(1)
		c4.set_opacity(1)
		c5.set_opacity(1)
		c6.set_opacity(1)
	pass