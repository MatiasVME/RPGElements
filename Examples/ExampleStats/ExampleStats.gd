extends Node

func _ready():
	print("$RPGStats.get_stat_value(hola)", $RPGStats.get_stat_value("hola"))
	
	$RPGStats.add_stat("hola", 50)
	
	print("$RPGStats.get_stat_value(hola): ", $RPGStats.get_stat_value("hola"))
	print("$RPGStats.get_stat(hola): ", $RPGStats.get_stat("hola"))
	
	var dict = {
		Stat1 = 1,
		Stat2 = 2,
		Stat3 = 3
	}

	$RPGStats.set_serialized(dict)

	print("$RPGStats.get_serialized(): ", $RPGStats.get_serialized())
	
	$RPGStats.add_points(5)
	$RPGStats.add_points_to_stat(3, "Stat1")
	
	print("$RPGStats.get_serialized(): ", $RPGStats.get_serialized())
	
	$RPGStats.remove_points_to_stat(100, "Stat1")
	$RPGStats.remove_points_to_stat(1, "Stat2")
	
	print("$RPGStats.get_serialized(): ", $RPGStats.get_serialized())