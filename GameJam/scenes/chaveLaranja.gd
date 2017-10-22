extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func Chave(temChave):
	if(temChave):
		get_node("chala").set_animation("tem")
	else:
		get_node("chala").set_animation("ntem")
	pass


