extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_process(true)
	pass
func _process(delta):
	pass

func Chave(temChave):
	if(temCha):
		get_node("laranja").set_animation("Com")
	else:
		get_node("laranja").set_animation("Sem")
	pass

