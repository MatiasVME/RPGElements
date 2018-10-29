extends Node

onready var pedro = get_node("Pedro")

func _ready():
	# Pedro es un player, podría también podría ser un character NPC
	pedro.player_name = "Pedro"
	
	# Añade xp y sube de nivel
	pedro.add_xp(1)
	pedro.add_xp(10)
	pedro.add_xp(100)
#	pedro.add_xp(10000) # Para testear el último nivel
	
	# HP
	#
	
	pedro.remove_hp(3) # OK
	pedro.remove_hp(5) # OK
	pedro.remove_hp(100) # OK
	
	pedro.revive() # OK
	
	print("HP actual: ", pedro.hp)
	pedro.remove_hp(5) # OK
	pedro.add_hp(1) # OK
	pedro.add_hp(100) # OK
	pedro.add_hp(10) # OK
	pedro.remove_hp(9) # OK
	pedro.add_hp(1000) # OK
	print("HP actual: ", pedro.hp)

	# Energía
	#

	print("energy actual: ", pedro.energy)
	pedro.remove_energy(5) # OK
	pedro.add_energy(1) # OK
	pedro.add_energy(100) # OK
	pedro.add_energy(10) # OK
	pedro.remove_energy(9) # OK
	pedro.add_energy(1000) # OK
	print("energy actual: ", pedro.energy)
	
	# Damage (recibe daño, toma en cuenta la defensa)
	# 
	
	pedro.damage(1)
	pedro.damage(3)
	pedro.damage(5)
	pedro.set_defense_rate(50)
	pedro.damage(30)