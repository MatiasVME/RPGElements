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

tool
extends "RPGElement.gd"

var player_name setget set_player_name, get_player_name
# Inventario/s asigando/s a el player
var inv = []

# Todos los player tienen stats
var stats = preload("RPGStats.gd").new() 

var level = 0
var level_max = 30

var xp = 0
# En xp_required 0 equivale a level 1
var xp_required = [] setget , get_xp_required

signal level_up
signal get_xp

func _ready():
	create_default_xp_curve()
	
	# Signals
	connect("level_up", self, "_on_level_up")
	connect("get_xp", self, "_on_get_xp")

func _on_level_up():
	debug("Level Up!!: ", level)
	
func _on_get_xp():
	debug("Get XP")

# Métodos Públicos
#

func create_default_xp_curve(base_xp = 20.4, exponent = 1.05):
	xp_required.clear()
	
	for i in range(1, level_max + 1):
		xp_required.append(int(round(base_xp * (pow(float(i), exponent)))))
	
	debug(xp_required)

# Añade xp y sube de nivel si es necesario
func add_xp(_xp):
	if _xp > 0:
		emit_signal("get_xp")
	
	var i = xp
	while(i < xp + _xp):
		if level >= level_max:
			break
		
		if xp + _xp >= xp_required[level]:
			if i != 0:
				i += xp_required[level] - xp_required[level - 1]
			else:
				i += xp_required[level]
				
			level += 1
			emit_signal("level_up")
		else:
			break
			
	xp += _xp
	debug(xp)
	
func remove_xp(_xp):
	if xp - _xp >= 0:
		xp -= _xp
	else:
		xp = 0

func add_inv(_inv):
	inv.append(_inv)

func remove_inv(inv_name):
	pass

# Setters/Getters
#

func set_serialized(dict):
	pass

func get_serialized():
	pass

func get_xp_required():
	return xp_required

func set_player_name(_player_name):
	player_name = _player_name
	
func get_player_name():
	return player_name
	
func get_inv(index):
	return inv[index]

func get_all_inv():
	return inv

# Métodos "Privados"
#