extends Node

func _ready():
	# Se recomienda utilizar este plugin con PersistenceNode para
	# almacenar los datos. Este se debe añadir al autoload.
	# https://github.com/MatiasVME/Persistence
	
	$Pedro.player_name = "Pedro"
	
	# Se obtiene la data del jugador si es que esta almacenada a travéz
	# del PersistenceNode 
	var player_data = Persistence.get_data($Pedro.player_name)
	
	# Añade xp y sube de nivel, se genera una curva de experiencia
	# automaticamente pero esta se puede editar. Por medio de:
	# create_default_xp_curve(base_xp = 20.4, exponent = 1.05)
	$Pedro.add_xp(100)
	$Pedro.add_xp(10)
	$Pedro.add_xp(1)

	# Se le pone un nombre al inventario para poder identificarlo,
	# ya que puede haber más de un inventario.
	$Pedro/Inv.inv_name = "PlayerInventory"
	# Le asigna un peso máximo de 40 entre todos los items no pueden
	# superar ese peso.
	$Pedro/Inv.max_weight = 40
	# Se añade el inventario al player Pedro.
	$Pedro.add_inv($Pedro/Inv)

	# Se almacena en el diccionario de pedro, la data serializada de
	# pedro.
	player_data["PlayerData"] = $Pedro.get_serialized()

	# Siempre es importante guardar la data en disco.
	Persistence.save_data($Pedro.player_name)