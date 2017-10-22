extends KinematicBody2D

const TAM_X = 1024
const TAM_Y = 720
const GRAVITY = 400.0
const JUMP_FORCE = 300.0
const CAN_JUMP_TIME_LIMIT = 1.0 #seconds we are not allowed to jump
var posicaoInicial = Vector2()
var movimentosGhost1 = []
var movimentosGhost2 = []
var movimentosGhost3 = []
var movimentosGhost4 = []
var ghost1
var ghost2
var ghost3
var ghost4
var ghostV = 0


var vidasMostrando = []
var contGhost = 1
var pre_tiro = preload("res://scenes/tiro.tscn")
var pre_vida = preload("res://scenes/Vida.tscn")
var pre_chaveLaranja = preload("res://scenes/chaveLaranja.tscn")
var ChaveL = pre_chaveLaranja.instance()
var pre_ghost = preload("res://scenes/Ghost.tscn")
var pre_label = preload("res://scenes/score.tscn")
export var vel = 250
var jump_allowed_time = 0

var intervalo = .3
var ultimo_disparo = 0
var mostVida = 0
var velocity = Vector2() 
var direcao = 1
var vidas = 0
var scoreAtual = 0
export var Smoothness = 0.1

onready var heroiAnimacoes = get_node("heroiAnimacoes")
onready var arma = get_node("arma")

func _ready():
	add_to_group(game.GRUPO_HEROI)
	set_process(true)
	vidas = game.vida
	scoreAtual = game.score
	posicaoInicial = get_global_pos()
	pass
	

func _process(delta):
	var num = 0
	var direction = 0
	if(mostVida == 0):
		mostVida  = 1
		mostrarVida()
		mostrarChave()
		#mostrarScore()
		
		
	
	velocity.y += delta * GRAVITY
	
	if jump_allowed_time > 0:
		jump_allowed_time -= delta
	
	if Input.is_action_pressed("direita"):
		AndaDireita()
		num = 1
		direction = 1
		direcao = 1
		pass
	
	if Input.is_action_pressed("esquerda"):
		AndaEsquerda()
		num = 2
		direcao = -1
		direction = -1
		pass
	if(direction + direction == 0):
		heroiAnimacoes.set_animation("Parado")
		num = 0
		pass
	if Input.is_action_pressed("Morrer") : 	
		if ghostV <= 0:
			gerarGhost(delta)
			#mostrarScore()
		pass
	velocity.x = lerp(velocity.x, vel * direction, Smoothness)
	setPosicaoArma()
	var motion = velocity * delta
	move(motion)
	
	if is_colliding():
		var normal = get_collision_normal()
		motion = normal.slide(motion)
		velocity = normal.slide(velocity)
		move(motion)
		
		if Input.is_action_pressed("pular") && is_jump_allowed():
			velocity.y -= JUMP_FORCE
			num = 4
			jump_allowed_time = CAN_JUMP_TIME_LIMIT
			
			
	if game.morreu == true:
		game.morreu = false
		gerarGhost(delta)
		
	verifica_morreu(delta)
	
	if Input.is_action_pressed("tiro"):
		if ultimo_disparo <= 0:
			dispara(get_node("posArma"))
			num = 3
			ultimo_disparo = intervalo
		pass
	
	if ultimo_disparo > 0:
		ultimo_disparo -= delta
	if ghostV > 0:
		ghostV  -= delta

	pass
	if(contGhost < 5):
		gravarMovimento(num)
	pass
func dispara(node):
	var tiro = pre_tiro.instance()
	if(direcao == 1):
		tiro.set_global_pos(node.get_global_pos())
		pass
	if(direcao == -1):
		tiro.set_global_pos(Vector2(get_global_pos().x - 70 ,node.get_global_pos().y))
		pass
	tiro.vetor = direcao
	
	get_owner().add_child(tiro)
	pass
	
func AndaDireita():
	if(heroiAnimacoes.get_animation() != "AndandoDireita" || direcao == -1 ):
		heroiAnimacoes.set_animation("AndandoDireita")
		heroiAnimacoes.set_flip_h(false)
		heroiAnimacoes.play()
	pass
	
func AndaEsquerda():
	if(heroiAnimacoes.get_animation() != "AndandoDireita" || direcao == 1 ):
		heroiAnimacoes.set_animation("AndandoDireita")
		heroiAnimacoes.set_flip_h(true)
		heroiAnimacoes.play()
		pass
	pass
	
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
	
	
func is_jump_allowed():
	return (jump_allowed_time <= 0)

func gerarGhost(delta):
	tirarVida()
	set_global_pos(posicaoInicial)
	ghostV = intervalo
	if(contGhost >= 1):
		ghost1 = pre_ghost.instance()
		ghost1.set_pos(posicaoInicial)
		ghost1.movimentos = movimentosGhost1
		ghost1.delta =delta
		ghost1.cont = 0
		add_collision_exception_with(ghost1)
		get_owner().add_child(ghost1)
	if(contGhost >= 2):
		ghost2= pre_ghost.instance()
		ghost2.set_pos(posicaoInicial)
		ghost2.movimentos = movimentosGhost2
		ghost2.delta =delta
		ghost2.cont = 0
		add_collision_exception_with(ghost2)
		ghost2.add_collision_exception_with(ghost1)
		get_owner().add_child(ghost2)
	if(contGhost >= 3):
		ghost3 = pre_ghost.instance()
		ghost3.set_pos(posicaoInicial)
		ghost3.movimentos = movimentosGhost3
		ghost3.delta =delta
		ghost3.cont = 0
		add_collision_exception_with(ghost3)
		ghost3.add_collision_exception_with(ghost1)
		ghost3.add_collision_exception_with(ghost2)
		get_owner().add_child(ghost3)
	if(contGhost >= 4):
		ghost4 = pre_ghost.instance()
		ghost4.set_pos(posicaoInicial)
		ghost4.movimentos = movimentosGhost4
		ghost4.delta =delta
		ghost4.cont = 0
		add_collision_exception_with(ghost4)
		ghost4.add_collision_exception_with(ghost1)
		ghost4.add_collision_exception_with(ghost2)
		ghost4.add_collision_exception_with(ghost3)
		get_owner().add_child(ghost4)
	
	contGhost = contGhost + 1
	
	pass
	
func gravarMovimento(mov):
	if(contGhost == 1):
		movimentosGhost1.append(mov)
	if(contGhost == 2):
		movimentosGhost2.append(mov)
	if(contGhost == 3):
		movimentosGhost3.append(mov)
	if(contGhost == 4):
		movimentosGhost4.append(mov)
	pass
	
func mostrarVida():
	var umaVida
	var i = 0
	while(i < vidas):
		umaVida = pre_vida.instance()
		umaVida.set_global_pos(Vector2(40 + 60 * i ,60))
		vidasMostrando.append(umaVida)
		get_owner().add_child(umaVida)
		i = i + 1
	
func tirarVida():
	var tirar = vidasMostrando[vidasMostrando.size() - 1]
	game.retirarPontos(100)
	scoreAtual = scoreAtual - 100
	vidasMostrando.remove(vidasMostrando.size() - 1)
	tirar.free()
	pass
	
func adicionarChaveLaranja():
	ChaveL.Chave(game.chaveLaranja)
	game.chaveLaranja=true
	
func removerChaveLaranja():
	ChaveL.Chave(game.chaveLaranja)
	game.chaveLaranja=false
	
func mostrarChave():
	ChaveL.set_global_pos(Vector2(525,60))
	ChaveL.Chave(game.chaveLaranja)
	get_owner().add_child(ChaveL)
	pass
	
func subir_escada():
	set_pos(Vector2(661, -500))
	pass
	
#func mostrarScore():
#	var x = String(scoreAtual)
#	get_node("score").set_text(x)
#	get_node("score").add_font_override("fonte",load("res://Fonts/fonte1.fnt"))
#	get_node("score").set_global_pos(Vector2(800,45))
#	pass

func verifica_morreu(delta):
	if get_pos().y > TAM_Y:
		gerarGhost(delta)
	
	pass
	
	
 
	
