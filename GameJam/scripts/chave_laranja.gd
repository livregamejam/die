extends Area2D

var ja_pegou_chave = 0

func _ready():
	set_process(true)
	pass
	
func _process(delta):
	if ja_pegou_chave == 1 && !get_node("anim").is_playing():
		queue_free()
		
	pass

func _on_chave_laranja_body_enter( body ):
	if ja_pegou_chave == 0:
		game.chaveLaranja = true
		body.adicionarChaveLaranja()
		get_node("anim").play("pegar_chave")
		ja_pegou_chave = 1
	pass # replace with function body
