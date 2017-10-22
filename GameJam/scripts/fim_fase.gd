extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	add_to_group(game.GRUPO_SAIDA)
	pass


func _on_fim_fase_body_enter( body ):
	if body.is_in_group(game.GRUPO_HEROI) :
		
		var path = (get_tree().get_root().get_child( get_tree().get_root().get_child_count() - 1 )).get_name()
		var tamanho = path.length()
		path = path.substr(7,tamanho-1)
		
		path = String(int(path) + 1)
		
		path = "res://scenes/cenario" + path + ".tscn"
		
		var file2Check = File.new()
		var doFileExists = file2Check.file_exists(path)
		
		print(doFileExists)
		
		if(doFileExists):
			get_node("/root/game").goto_scene(path)
		else:
			get_node("/root/game").goto_scene("res://scenes/tela_ganhou.tscn")
		pass
	pass # replace with function body
