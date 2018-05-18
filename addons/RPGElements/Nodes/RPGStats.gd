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

var stats = []
var points = 0

# Métodos Públicos
#

func add_stat(stat_name, points):
	stats.append([stat_name, points])
	
func add_points(_points):
	points += _points
	
func add_points_to_stat(cant, stat_name):
	if not cant > points:
		pass #TODO
	else:
		.debug("La cantidad dada, supera a la cantidad de puntos")

func clear_stats():
	stats.clear()
	stats = []



# Setters/Getters
#

func get_stat_value(stat_name):
	# range() no devuelve el último valor
	for i in range(0, stats.size()):
		if stats[i][0] == stat_name:
			return stats[i][1] # Retorna el valor de la stat

	.debug("No se ecuentra stat_name: ", stat_name)
	
# Para ser serializado debe de ser un diccionario con las siguientes
# características.
# dict = {
#   StatName1 = value,
#   StatName2 = value
# }
func set_serialized(dict):
	if typeof(dict) == TYPE_DICTIONARY:
		for i in range(0, dict.size()):
			# Obtener la key i y añadirlo al array con add_stat()
			# Obtener el value i y añadirlo al array con add_stat()
			add_stat(dict.keys()[i], dict.values()[i])
	else:
		.debug("No es diccionario")

# Ger serialized es para obtener el bojeto serializado para poder
# poder almacenarlo en disco.
func get_serialized():
	var serialized = {}
	
	for i in range(0, stats.size()):
		serialized[stats[i][0]] = stats[i][1]

	return serialized