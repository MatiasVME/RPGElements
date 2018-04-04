extends Node

func _ready():
	# Se recomienda utilizar este plugin con PersistenceNode para
	# almacenar los datos. Este se debe añadir al autoload.
	# https://github.com/MatiasVME/Persistence
	
	$Pedro.player_name = "Pedro"
	
	# Se obtiene la data del jugador si es que esta almacenada a travez
	# del PersistenceNode 
	var player_data = Persistence.get_data($Pedro.player_name)
	
	# Añade xp y sube de nivel, se genera una curva de experiencia
	# automaticamente pero esta se puede editar. Por medio de:
	# create_default_xp_curve(base_xp = 20.4, exponent = 1.05)
	$Pedro.add_xp(100)
	$Pedro.add_xp(10)
	$Pedro.add_xp(1)

	# Se almacena en el diccionario de pedro, la data serializada de
	# pedro.
#	player_data["PlayerData"] = $Pedro.get_serialized()

	# Siempre es importante guardar la data en disco.
#	Persistence.save_data($Pedro.player_name)
