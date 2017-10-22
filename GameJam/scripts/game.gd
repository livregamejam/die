extends Node

const GRUPO_INIMIGO = "inimigos"
const GRUPO_HEROI = "heroi"
const GRUPO_SAIDA = "saida"
var vida
var score
var current_scene = null
var chaveLaranja = false
var morreu = false

func _ready():
	vida = 5
	score = 1000 
	var root = get_tree().get_root()
	current_scene = root.get_child( root.get_child_count() - 1 )
	set_process(true)
	pass

func goto_scene(path):
	call_deferred("_deferred_goto_scene",path)

func adicionarPontos(n):
	score = score + n

func retirarPontos(n):
	score = score - n

func _deferred_goto_scene(path):
	# Immediately free the current scene,
    current_scene.free()

    # Load new scene
    var s = ResourceLoader.load(path)

    # Instance the new scene
    current_scene = s.instance()

    # Add it to the active scene, as child of root
    get_tree().get_root().add_child(current_scene)

    # optional, to make it compatible with the SceneTree.change_scene() API
    get_tree().set_current_scene( current_scene )