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

# Almacena las stats en si y los puntos relacionados con la stat, por
# ejemplo: [["Fuerza", 3], ["Inteligencia", 2]].
var stats = [] # No se debe editar directamente
# Puntos que se acumulan para añadir a las stats
var points = 0 setget , get_points # No se debe editar directamente

# Métodos Públicos
#

# Añadir una stat con una determinada cantidad de puntos
func add_stat(stat_name, points):
	stats.append([stat_name, points])

# Añadir puntos para acumular en points, estos puntos pueden ser usados
# para ser añadidos con el método add_points_to_stat()
func add_points(_points):
	if _points > 0:
		points += _points
	else:
		.debug("_points debe ser mayor que 0")

# Remueve una cantidad de puntos que son acumulados en points.
func remove_points(_points):
	if _points > 0:
		points -= _points
	else:
		.debug("_points debe ser mayor que 0")

# Toma puntos de points y los añade a x stat
func add_points_to_stat(cant, stat_name):
	if cant < points:
		points -= cant
		get_stat(stat_name)[1] += cant
	else:
		.debug("La cantidad dada, supera a la cantidad de puntos")

# Quita puntos a una stat y los guarda en points
func remove_points_to_stat(cant, stat_name):
	var stat = get_stat(stat_name)
	
	if cant > 0 and cant <= stat[1]:
		stat[1] -= cant
		points += cant
	else:
		.debug("No se puede remover esa cantidad de puntos      ")

# Borra todas las stats
func clear_stats():
	stats.clear()
	stats = []

# Setters/Getters
#

func get_points():
	return points

# Retorna el valor de la stat
func get_stat_value(stat_name):
	# range() no devuelve el último valor
	for i in range(0, stats.size()):
		if stats[i][0] == stat_name:
			return stats[i][1] 

	.debug("No se ecuentra stat_name: ", stat_name)

# Retorna el arreglo de la stat
func get_stat(stat_name):
	# range() no devuelve el último valor
	for i in range(0, stats.size()):
		if stats[i][0] == stat_name:
			return stats[i] 

	.debug("No se ecuentra stat_name: ", stat_name)

func get_stats():
	return stats

# Es para enviarle un diccionario y lo tansforma a objeto, el
# diccionario debe de tener la siguiente forma:
# dict = {
#   StatName1 = value,
#   StatName2 = value
# }
func set_dictionary(dict):
	if typeof(dict) == TYPE_DICTIONARY:
		for i in range(0, dict.size()):
			# Obtener la key i y añadirlo al array con add_stat()
			# Obtener el value i y añadirlo al array con add_stat()
			add_stat(dict.keys()[i], dict.values()[i])
	else:
		.debug("No es diccionario")

# Es para obtener el diccionario del objeto, esto es útil para
# serializar el objeto y luego almacenarlo en disco.
func get_dictionary():
	var dict = {}
	
	for i in range(0, stats.size()):
		dict[stats[i][0]] = stats[i][1]

	return dict