# MIT License
#
# Copyright (c) 2018 Matías Muñoz Espinoza
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# TODO:
#   + Mover algunas cosas de acá a RPGWeightInventory

tool
extends "RPGElement.gd"

# Los tipos de inventarios son el modo en el cuál se organizan los items,
# por el momento solo se pueden organizar por peso. (TYPE_BY_WEIGHT).
# TODO: TYPE_BY_SLOTS : A futuro agregar la opción de almacenar por slots
enum Type {TYPE_BY_WEIGHT}
export (Type) var type = TYPE_BY_WEIGHT

var inv = []
var inv_name = "" setget set_inv_name, get_inv_name

var max_weight = 20
var current_weight = 0

# Métodos Públicos
#

# Añade un item y retorna verdadero si lo puede añadir, si no puede retorna
# false.
func add_item(item):
	match type:
		TYPE_BY_WEIGHT:
			return add_item_by_weight(item)

# Obtiene un item y lo elimina del inventario
func take_item(item_name):
	match type:
		TYPE_BY_WEIGHT:
			return take_item_by_weight(item_name)

func remove_item(item_name):
	match type:
		TYPE_BY_WEIGHT:
			remove_item_by_weight(item_name)

# Setters/Getters
#

func set_serialized(dict):
	pass

func get_serialized():
	pass

func get_item(item_name):
	pass
	
func set_inv_name(_inv_name):
	inv_name = _inv_name
	
func get_inv_name():
	return inv_name
	
# Métodos "Privados"
#

func add_item_by_weight(item):
	if current_weight + item.weight <= max_weight:
		inv.append(item)
		current_weight += item.weight
		
		return true
		
	return false

func take_item_by_weight(item_name):
	return 99 # Nada
	pass
	
func remove_item_by_weight(item_name):
	pass