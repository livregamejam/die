extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_process(true)
	pass
func _process(delta):
	pass

func ComChave():
	get_node("laranja").set_animation("Com")
	get_node("laranja").play()

func SemChave():
	get_node("laranja").set_animation("Sem")
	get_node("laranja").play()
