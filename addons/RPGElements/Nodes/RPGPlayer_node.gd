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

var player_name
# Inventario/s asigando/s a el player
var inv = []

# Opcionales
var level
var level_max = 30

var xp
var xp_required = []

func _ready():
	create_default_xp_curve()

# Métodos Públicos
#

func create_default_xp_curve(base_xp = 20.4, exponent = 1.05):
	xp_required.clear()
	
	for i in range(1, level_max):
		xp_required.append(int(round(base_xp * (pow(float(i), exponent)))))
	
	debug(xp_required)
	
# Setters/Getters
#

func set_serialized(dict):
	pass
	
func get_serialized():
	pass

# Métodos "Privados"
#