tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("RPGCharacter", "Node", preload("Nodes/RPGCharacter.gd"), preload("Icons/RPGCharacter.png"))
	add_custom_type("RPGStats", "Node", preload("Nodes/RPGStats.gd"), preload("Icons/RPGStats.png"))
	add_custom_type("RPGWeightInventory", "Node", preload("Nodes/RPGWeightInventory.gd"), preload("Icons/RPGWeightInventory.png"))
	add_custom_type("RPGItem", "Node", preload("Nodes/RPGItem.gd"), preload("Icons/RPGItem.png"))
	add_custom_type("RPGDialog", "Node", preload("Nodes/RPGDialog.gd"), preload("Icons/RPGDialog.png"))

func _exit_tree():
	remove_custom_type("RPGCharacter")
	remove_custom_type("RPGStats")
	remove_custom_type("RPGWeightInventory")
	remove_custom_type("RPGItem")
	remove_custom_type("RPGDialog")