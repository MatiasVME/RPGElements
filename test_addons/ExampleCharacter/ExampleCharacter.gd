extends Node

onready var pedro = get_node("Pedro")

func _ready():
	# Pedro es un player, podría también podría ser un character NPC
	pedro.player_name = "Pedro"
	
	# SIMPRE, primero se debe crear una curva de experiencia,
	# sino, no se puede añadir xp.
	pedro.create_xp_curve()
	
	# Añade xp y sube de nivel
	pedro.add_xp(100)
	pedro.add_xp(10)
	pedro.add_xp(1)
	
	# HP
	pedro.add_hp(5)
	pedro.add_hp(5)
	
	pedro.remove_hp(3)
	pedro.remove_hp(7)
	
	pedro.add_hp(100)
	
	# Energía
	pedro.add_energy(5)
	pedro.remove_energy(3)
	pedro.add_energy(8)
	
	pedro.add_xp(500)
	
	
	