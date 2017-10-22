extends StaticBody2D

var descendo = 0

func _ready():
	pass


func _on_ponte_tora_area_body_enter( body ):
	if body.is_in_group(game.GRUPO_HEROI):
		if descendo == 0:
			descendo = 1
			get_node("anim").play("descer")
		pass # replace with function body

