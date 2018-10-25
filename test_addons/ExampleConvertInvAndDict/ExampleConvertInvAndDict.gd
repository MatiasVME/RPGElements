extends Node

onready var inv = get_node("Inv")

onready var item1 = get_node("Item1")
onready var item2 = get_node("Item2")

func _ready():
	inv.add_item(item1)
	inv.add_item(item2)
	
	var inv_dict = inv.inv2dict()
	print("inv_dict: ", inv_dict)
	
	var inv_inst = inv.dict2inv(inv_dict)
	print("inv_inst: ", inv_inst)
	print("inv_inst.get_inv(): ", inv_inst.get_inv())
	
	inv_dict = inv_inst.inv2dict()
	print("inv_dict: ", inv_dict)