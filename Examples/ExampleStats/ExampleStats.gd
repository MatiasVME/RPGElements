extends Node

func _ready():
	$RPGStats.get_stat_value("hola")
	$RPGStats.add_stat("hola", 3)
	print($RPGStats.get_stat_value("hola"))
	
#	var dict = {
#		Stat1 = 1,
#		Stat2 = 2,
#		Stat3 = 3
#	}
#
#	$RPGStats.set_serialized(dict)
#
#	print($RPGStats.get_serialized())
	
	