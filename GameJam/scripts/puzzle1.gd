extends StaticBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var bar = get_node("barreiraBody/barreira")
onready var coBar = get_node("coBarreira")
onready var btn_ver = get_node("botao_verde")
func _ready():
	set_process(true)
	pass
	
func _process(delta):
	
	if(btn_ver.ativado && bar.get_global_pos().y < 733.34436):
		bar.set_global_pos(Vector2(bar.get_global_pos().x,bar.get_global_pos().y + 18))
		coBar.set_global_pos(Vector2(coBar.get_global_pos().x,coBar.get_global_pos().y + 18))
	else:
		if(btn_ver.ativado != true && bar.get_global_pos().y > 571.34436):
			bar.set_global_pos(Vector2(bar.get_global_pos().x,bar.get_global_pos().y - 18))
			coBar.set_global_pos(Vector2(coBar.get_global_pos().x,coBar.get_global_pos().y - 18))
			
	
		
