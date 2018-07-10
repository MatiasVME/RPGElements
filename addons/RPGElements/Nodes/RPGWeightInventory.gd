# MIT License
#
# Copyright (c) 2018 Matías Muñoz Espinoza
# Copyright (c) 2018 Jovani Pérez
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

extends "RPGInventory.gd"

var max_weight = 20
var current_weight = 0 setget , get_current_weight

# Métodos Públicos y Setters/Getters
#
func add_item(item):
	var weight = calculeCurrentWeight()
	print("Peso antes: " + str(weight))
	weight += item.weight * item.amount
	print("Peso al agregar: " + str(weight))
	if max_weight < weight:
		set_full()
	else:
		reset_full()
	if .add_item(item):
		current_weight = weight
	else:
		print("Inventario lleno")

func remove_item(item):
	if .remove_item(item):
		current_weight = calculeCurrentWeight()
		return true
	return false

func add_max_weight(weight):
	max_weight += weight
	
func remove_max_weight(weight):
	if max_weight - weight >= 4:
		max_weight -= weight

func get_current_weight():
	return current_weight

# Métodos "Privados"
#

func calculeCurrentWeight():
	var result = 0
	for item in get_inv().values():
		result += item.weight * item.amount
	return result