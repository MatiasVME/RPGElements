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

tool
extends "RPGElement.gd"

var item_name = "" setget set_item_name, get_item_name
# Descripción
var desc = "" setget set_desc, get_desc
var identifier = -1
var amount = 1
var stack_max = 10
# Precio de compra de un item
var price = 100
# Precio de venta de un item
var sell_price = 50 setget set_sell_price, get_sell_price
# Imagen del item
var texture_path setget set_texture_path, get_texture_path

# Opcionales
var weight = 1 setget set_weight, get_weight
var atributes = []

# Métodos Públicos y Setters/Getters
#

func create_item(_item_name, _desc, _amount = 1):
	item_name = _item_name
	desc = _desc
	amount = _amount

func set_item_name(_item_name):
	item_name = _item_name
	
func get_item_name():
	return item_name
	
func set_desc(_desc):
	desc = _desc
	
func get_desc():
	return desc
	
func set_price(_price):
	price = _price
	
func get_price():
	return price

func add_atribute(atribute_name, value):
	atributes.append([atribute_name, value])

func set_weight(_weight):
	weight = _weight
	
func get_weight():
	return weight

func set_sell_price(_sell_price):
	sell_price = _sell_price

func get_sell_price():
	return sell_price

func set_texture_path(_texture_path):
	texture_path = _texture_path

func get_texture_path():
	return texture_path

# Obtienes los atributos para ser imprimidos
func get_atributes_to_print():
	var to_print = ""
	
	for i in range(0, atributes.size()):
		to_print += str(atributes[i][0], ": ", atributes[i][1], "\n")

	return to_print

# Métodos "Privados"
#