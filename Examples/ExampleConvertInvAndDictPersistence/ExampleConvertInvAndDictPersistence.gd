extends Node

onready var inv = get_node("Inv")

onready var item1 = get_node("Item1")
onready var item2 = get_node("Item2")

# IMPORTANTE: Requiere plugin "PersistenceNode":
# https://github.com/MatiasVME/Persistence/tree/for-godot-2.1
onready var persistence = get_node("Persistence")

var data

func _ready():
	inv.add_item(item1)
	inv.add_item(item2)
	
	data = persistence.get_data()
	
	if not data.has("AllData"):
		data["AllData"] = inv.inv2dict()
	else:
		var nueva_data_inv
		var nueva_data_dict
		
		nueva_data_inv = inv.dict2inv(data["AllData"])
		nueva_data_dict = nueva_data_inv.inv2dict()
	
	persistence.save_data()
	