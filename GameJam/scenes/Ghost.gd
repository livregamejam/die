extends KinematicBody2D
var movimentos = []
var delta = 0
var cont = - 1
const TAM_X = 1024
const TAM_Y = 720
const GRAVITY = 400.0
const JUMP_FORCE = 300.0
const CAN_JUMP_TIME_LIMIT = 1.0 #seconds we are not allowed to jump
var pre_tiro = preload("res://scenes/tiro.tscn")
export var vel = 250
var jump_allowed_time = 0
var intervalo = .3
var ultimo_disparo = 0

var velocity = Vector2() 
var direcao = 1
export var Smoothness = 0.1
var doit = 0
onready var arma = get_node("arma")

func _ready():
	set_process(true)
	add_to_group(game.GRUPO_HEROI)
	pass
	

func _process(delta):
	var n = 0
	var direction = 0
	velocity.y += delta * GRAVITY
	if(movimentos.size() > cont):
		n = movimentos[cont]
		cont = cont + 1
	else:
		queue_free()

	
	if(n == 1):
		AndaDireita()
		direction = 1
		direcao = 1

	if(n == 2):
		AndaEsquerda()
		direction = -1
		direcao = -1
		
	velocity.x = lerp(velocity.x, vel * direction, Smoothness)
	setPosicaoArma()
	var motion = velocity * delta
	move(motion)
	if is_colliding() :
		var normal = get_collision_normal()
		motion = normal.slide(motion)
		velocity = normal.slide(velocity)
		move(motion)
		if n == 4:
			velocity.y -= JUMP_FORCE
			jump_allowed_time = CAN_JUMP_TIME_LIMIT
			
	if(n == 3):
		dispara(get_node("posArma"))
		ultimo_disparo = intervalo
	pass
	if(direction == 0):
		parado()
	
	
	if ultimo_disparo > 0:
		ultimo_disparo -= delta
	
	
func AndaDireita():
	if(get_node("heroiAnimacoes").get_animation() != "AndandoDireita" || direcao == -1 ):
		get_node("heroiAnimacoes").set_animation("AndandoDireita")
		get_node("heroiAnimacoes").set_flip_h(false)
		get_node("heroiAnimacoes").play()
	pass
	
func AndaEsquerda():
	if(get_node("heroiAnimacoes").get_animation() != "AndandoDireita" || direcao == 1 ):
		get_node("heroiAnimacoes").set_animation("AndandoDireita")
		get_node("heroiAnimacoes").set_flip_h(true)
		get_node("heroiAnimacoes").play()
		pass
	pass
func parado():
	get_node("heroiAnimacoes").set_animation("Parado")
	get_node("heroiAnimacoes").play()
func dispara(node):
	var tiro = pre_tiro.instance()
	if(direcao == 1):
		tiro.set_global_pos(node.get_global_pos())
		pass
	if(direcao == -1):
		tiro.set_global_pos(Vector2(get_global_pos().x - 70 ,node.get_global_pos().y))
		pass
	tiro.vetor = direcao
	get_parent().add_child(tiro)
	pass
	
func is_jump_allowed():
	return (jump_allowed_time <= 0)
	
func setPosicaoArma():
	if(direcao == 1):
		arma.set_flip_h(false)
		arma.set_global_pos(Vector2(get_global_pos().x + 34 ,arma.get_global_pos().y))
		pass
	if(direcao == -1):
		arma.set_flip_h(true)
		arma.set_global_pos(Vector2(get_global_pos().x - 43 ,arma.get_global_pos().y))
		pass
	pass