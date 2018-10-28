extends Node

onready var pedro = get_node("Pedro")

func _ready():
	# Pedro es un player, podría también podría ser un character NPC
	pedro.player_name = "Pedro"
	
	# Añade xp y sube de nivel
	pedro.add_xp(1)
	pedro.add_xp(10)
	pedro.add_xp(100)
	
	# HP
	#
	
	pedro.remove_hp(3) # OK
	pedro.remove_hp(5) # OK
	pedro.remove_hp(100) # OK
	
	pedro.revive() # OK
	
	print("HP actual: ", pedro.hp)
	pedro.remove_hp(5) # OK
	pedro.add_hp(1)
	pedro.add_hp(50) # OK
	pedro.add_hp(10) # OK
	pedro.remove_hp(9) # OK
	pedro.add_hp(100) # OK
	print("HP actual: ", pedro.hp)

	# Energía
	#

	print("energy actual: ", pedro.energy)
	pedro.remove_energy(5) # 
	pedro.add_energy(1)
	pedro.add_energy(50) # 
	pedro.add_energy(10) # 
	pedro.remove_energy(9) #
	pedro.add_energy(100) # 
	print("energy actual: ", pedro.energy)
