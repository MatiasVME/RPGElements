extends Node

func _ready():
	# Pedro es un player, podría también podría ser un character NPC
	$Pedro.player_name = "Pedro"
	
	# Añade xp y sube de nivel, se genera una curva de experiencia
	# automaticamente pero esta se puede editar. Por medio de:
	# create_default_xp_curve(base_xp = 20.4, exponent = 1.05)
	$Pedro.add_xp(100)
	$Pedro.add_xp(10)
	$Pedro.add_xp(1)
	
	# HP
	$Pedro.add_hp(5)
	$Pedro.add_hp(5)
	
	$Pedro.remove_hp(3)
	$Pedro.remove_hp(7)
	
	$Pedro.add_hp(100)
	
	# Energía
	$Pedro.add_energy(5)
	$Pedro.remove_energy(3)
	$Pedro.add_energy(8)