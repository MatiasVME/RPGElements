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

extends "RPGElement.gd"

var inv = {} #setget set_inv, get_inv
var inv_name = "" setget set_inv_name, get_inv_name
var inventory_full = false setget , is_full

func _init():
	rand_seed(199)

# Métodos Públicos y Setters/Getters
#

func set_inv(_inv):
	inv = _inv
	
func get_inv():
	return inv

# Añade el item sin pensarlo
func add_item(item):
	if not is_full():
		var existing_item = search_item(item.get_item_name())
		item.identifier = get_identifier()
		
		if existing_item != null:
			if not check_stack_full(existing_item, item):
				inv[str(existing_item.identifier)].amount += item.amount
				return true
		
		inv[str(item.identifier)] = item
		return true
		
	return false

func check_stack_full(item, newitem):
	if (inv[str(item.identifier)].amount + newitem.amount) <= inv[str(item.identifier)].stack_max:
		return false
	else:
		return true

func take_item(item_name):
	var item = search_item(item_name)
	if item != null:
		remove_item(item)
		item.amount = 1
	
	return item
	
# Remueve el item
func remove_item(item):
	if inv.has(str(item.identifier)):
		if inv[str(item.identifier)].amount >= 1:
			inv[str(item.identifier)].amount -= 1
		
		if inv[str(item.identifier)].amount == 0:
			inv.erase(str(item.identifier))
		return true

	return false

func search_item(item_name):
	for item in inv.values():
		if item.get_item_name() == item_name:
			var newitem = preload("res://addons/RPGElements/Nodes/RPGItem.gd").new()#item.duplicate(true)
			newitem.set_item_name(item.get_item_name())
			newitem.set_desc(item.get_desc())
			newitem.identifier = item.identifier
			newitem.amount = item.amount
			newitem.stack_max = item.stack_max
			newitem.weight = item.weight
			newitem.atributes = item.atributes
			return newitem
	return null
	
func set_inv_name(_inv_name):
	inv_name = _inv_name
	
func get_inv_name():
	return inv_name

func set_full():
	inventory_full = true

func reset_full():
	inventory_full = false

func is_full():
	return inventory_full

# Métodos "Privados"
#

func get_identifier():
	randomize()
	var id = int(rand_range(1, 100000))
	while inv.has(id):
		id = int(rand_range(1, 100000))
	return id