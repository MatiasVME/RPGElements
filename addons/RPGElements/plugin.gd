tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("RPGPlayer", "Node", preload("Nodes/RPGPlayer.gd"), preload("Icons/RPGPlayer_node.png"))
	add_custom_type("RPGStats", "Node", preload("Nodes/RPGStats.gd"), preload("Icons/RPGStats_node.png"))
	add_custom_type("RPGInventory", "Node", preload("Nodes/RPGInventory.gd"), preload("Icons/RPGInventory_node.png"))
	add_custom_type("RPGItem", "Node", preload("Nodes/RPGItem.gd"), preload("Icons/RPGItem_node.png"))

func _exit_tree():
	remove_custom_type("RPGPlayer")
	remove_custom_type("RPGStats")
	remove_custom_type("RPGInventory")
	remove_custom_type("RPGItem")