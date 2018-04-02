tool
extends Node

# Los tipos de inventarios son el modo en el cuál se organizan los items,
# por el momento solo se pueden organizar por peso. (TYPE_BY_WEIGHT).
# TODO: TYPE_BY_SLOTS : A futuro agregar la opción de almacenar por slots
enum Type {TYPE_BY_WEIGHT}
export (Type) var type = TYPE_BY_WEIGHT

var inv = []

# Métodos Públicos
#

func add_item(item):
	match type:
		TYPE_BY_WEIGHT:
			add_item_by_weight(item)

# Setters/Getters
#

func set_serialized(dict):
	pass

func get_serialized():
	pass

func get_item():
	pass
	
# Métodos "Privados"
#

func add_item_by_weight(item):
	pass
