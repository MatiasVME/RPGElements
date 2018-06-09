extends Node

onready var pedro = get_node("Pedro")

func _ready():
	# Pedro es un player, podría también podría ser un character NPC
	pedro.player_name = "Pedro"
	
	# Añade xp y sube de nivel, se genera una curva de experiencia
	# automaticamente pero esta se puede editar. Por medio de:
	# create_default_xp_curve(base_xp = 20.4, exponent = 1.05)
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
	
	var data = Persistence.get_data()
	data["datos"] = inst2dict(pedro)
#	print(data)
	Persistence.save_data()
